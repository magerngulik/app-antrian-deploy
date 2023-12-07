import 'dart:async';

import 'package:antrian_app/core.dart';
import 'package:antrian_app/main.dart';
import 'package:antrian_app/module/layar/data/costumer_layar_services.dart';
import 'package:antrian_app/module/layar/widget/last_data_model.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../view/layar_view.dart';

class LayarController extends GetxController {
  LayarView? view;
  @override
  void onInit() {
    super.onInit();
    getDataOnce();
    startDataFetching();
    controllerVideoSupabase = VideoPlayerController.networkUrl(
      formatHint: VideoFormat.hls,
      Uri.parse(mediaVideo!['link']),
      // closedCaptionFile: _loadCaptions(),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    controllerVideoSupabase!.addListener(() {
      update();
    });
    controllerVideoSupabase!.setLooping(true);
    controllerVideoSupabase!.initialize();
    // getDataCurrent();
    // getLastDataQueue();
  }

  @override
  void onClose() {
    super.onClose();
    controllerVideoSupabase!.dispose();
    stopDataFetching();
  }

  getLastDataQueue() async {
    try {
      final currentTimestamp = DateTime.now();
      final startOfDay = DateTime(
          currentTimestamp.year, currentTimestamp.month, currentTimestamp.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final data = await supabase
          .from('queues')
          .select('*,assignments(*,role_users(*,code_queues(*)))')
          .eq('status', 'process')
          // .gte('created_at', startOfDay.toIso8601String())
          // .lte('created_at', endOfDay.toIso8601String())
          .order('created_at', ascending: true);
      Ql.logF(data);
      var dataQueue = DataModel.fromJson(data[0]);
      Map existQueue = {};
      if (data.isEmpty) {
        existQueue = {
          "kode": "-",
          "status": "-",
          "nama_role": "-",
          "created_at": "-",
          "updated_at": "-"
        };
      } else {
        existQueue = {
          "kode": dataQueue.kode,
          "status": dataQueue.status,
          "nama_role": dataQueue.assignments.roleUsers.nameRole,
          "created_at": dataQueue.createdAt,
          "updated_at": dataQueue.updatedAt
        };
        var kode = dataQueue.kode;
        loket = existQueue['nama_role'];
        kodePelayanan = kode;
        Ql.logFatal(existQueue);

        mVoiceCall(
            kode: dataQueue.kode,
            timeCreated: dataQueue.createdAt,
            timeUpdate: dataQueue.updatedAt,
            loket: existQueue['nama_role']);

        debugPrint("created qqq${dataQueue.createdAt}");

        saveTemporaryData(
            kode: dataQueue.kode,
            timeCreated: dataQueue.createdAt,
            timeUpdate: dataQueue.updatedAt);
      }
      update();
    } catch (e) {
      Ql.logFatal(e);
    }
  }

  var services = CostumerLayarServices();
  List<Map<String, dynamic>> dataList = [];
  String kodePelayanan = "-";
  String loket = "-";
  String createdAt = "";
  String updatedAt = "";
  Timer? dataTimer;
  VideoPlayerController? controllerVideoSupabase;

  // variable supabase
  var currentQueue = [];
  var currentRole = [];
  var currentAssigment = [];

  //var queue last data

  //mulai dari sini
  getDataCurrent() async {
    try {
      final currentTimestamp = DateTime.now();
      final startOfDay = DateTime(
          currentTimestamp.year, currentTimestamp.month, currentTimestamp.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final dataQueue = await supabase
          .from('queues')
          .select('*')
          .eq('status', 'process')
          .gte('created_at', startOfDay.toIso8601String())
          .lte('created_at', endOfDay.toIso8601String())
          .limit(20);

      if (dataQueue.isEmpty) {
        Ql.logD("data antrian kosong");
      } else {
        currentQueue = dataQueue;
      }

      Ql.logW(dataQueue);
    } catch (e) {
      Ql.logE("Terjadi error ketika get queue hari ini", e);
    }

    try {
      final dataRole = await supabase.from('role_users').select('*');
      if (dataRole.isEmpty) {
        Ql.logD("data antrian kosong");
      } else {
        currentRole = dataRole;
      }
      Ql.logI(currentRole);
    } catch (e) {
      Ql.logE("Terjadi error ketika get role users hari ini", e);
    }

    try {
      final currentTimestamp = DateTime.now();
      final startOfDay = DateTime(currentTimestamp.year, currentTimestamp.month,
          currentTimestamp.day, 0, 0, 0);
      final endOfDay = DateTime(currentTimestamp.year, currentTimestamp.month,
          currentTimestamp.day, 23, 59, 59);

      final dataAssignment = await supabase
          .from('assignments')
          .select('*')
          .gte('created_at', startOfDay.toIso8601String())
          .lte('created_at', endOfDay.toIso8601String());
      Ql.logW(dataAssignment);
      if (dataAssignment.isEmpty) {
        Ql.logD("data antrian kosong");
      } else {
        currentAssigment = dataAssignment;
      }
    } catch (e) {
      Ql.logE("Terjadi error ketika get assignment hari ini", e);
      return;
    }

    List<Map<String, dynamic>> result = [];
    // List<Map<String, dynamic>> resultCurrent = currentAssigment;
    List<Map<String, dynamic>> resultCurrent = [];

    for (var item in currentAssigment) {
      if (item is Map<String, dynamic>) {
        resultCurrent.add(item);
      } else {
        resultCurrent.add({'value': item});
      }
    }

    for (var r in currentRole) {
      var assignmentData = resultCurrent.firstWhereOrNull((element) {
        return element['role_users_id'] == r['id'];
      });
      Ql.logI(assignmentData);
      // Ql.logF(assignmentData);
      Map tempAssignment = assignmentData ?? {};
      String? tempUserId = tempAssignment['user_id'];
      int? assignmentId = tempAssignment['id'];
      int? codeId = r['code_id'];
      String nameUser = "";
      if (tempUserId != null) {
        final dataUser = await supabase
            .from('users')
            .select('*')
            .eq('id', tempUserId)
            .limit(1);
        nameUser = dataUser[0]['name'];
      }
      Map dataQueue = {};

      if (assignmentData != null) {
        if (currentQueue.isNotEmpty) {
          dataQueue = currentQueue.firstWhereOrNull(
              (e) => e['assignments_id'] == assignmentData['id']);

          if (dataQueue.isEmpty) {
            dataQueue = {};
          }
        } else {
          // Handle jika currentQueue null atau list kosong
          dataQueue = {}; // Atau lakukan sesuatu sesuai kebutuhan aplikasi Anda
        }
      } else {
        // Handle jika assignmentData null
        dataQueue = {}; // Atau lakukan sesuatu sesuai kebutuhan aplikasi Anda
      }

      result.add({
        "id": r['id'],
        "nama_role": r['name_role'],
        "id_user": tempUserId,
        "name": nameUser,
        "code_id": codeId,
        "assignment_id": assignmentId,
        "queue": dataQueue
      });
    }

    dataList = result;
    update();
    Ql.logF(result);
  }

  // berakhir di sini
  void startDataFetching() {
    Duration duration = const Duration(seconds: 15);
    dataTimer = Timer.periodic(duration, (Timer timer) {
      // getData();
      // getDataCurrent();
      getDataCurrent();
      getLastDataQueue();
    });
  }

  void stopDataFetching() {
    dataTimer?.cancel(); // Hentikan timer jika diperlukan
  }

  void getDataOnce() async {
    await getDataCurrent();
    await getLastDataQueue();
    await getDataCurrent();
  }

  // getData() async {
  //   debugPrint("di panggil ulang");
  //   var data = await services.viewQueue();
  //   data.fold((l) {
  //     debugPrint("error: $l");
  //   }, (r) {
  //     debugPrint(r.toString());
  //     if (r['data'] == null) {
  //       debugPrint("data kosong");
  //     } else {
  //       var lastData = r['data']['last'];
  //       dataList.clear();
  //       for (var item in r['data']['user_aktif']) {
  //         if (item is Map<String, dynamic>) {
  //           dataList.add(item);
  //         }
  //       }
  //       kodePelayanan = lastData['kode'];
  //       loket = lastData['nama_role'];
  //       createdAt = lastData['created_at'];
  //       updatedAt = lastData['updated_at'];
  //       update();
  //       debugPrint("created_at: $createdAt");

  //       mVoiceCall(
  //           kode: kodePelayanan,
  //           timeCreated: createdAt,
  //           timeUpdate: updatedAt,
  //           loket: loket);

  //       saveTemporaryData(
  //           kode: kodePelayanan, timeCreated: createdAt, timeUpdate: updatedAt);
  //     }
  //   });
  // }

  saveTemporaryData({
    required String kode,
    required String timeCreated,
    required String timeUpdate,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('kodePelayanan', kodePelayanan);
    prefs.setString('loket', loket);
    prefs.setString('createdAt', timeCreated);
    prefs.setString('updatedAt', timeUpdate);
    Ql.logW("ini kode nya: $kode, $timeCreated, $timeUpdate");
  }

  mVoiceCall(
      {required String kode,
      required String timeCreated,
      required String timeUpdate,
      required String loket}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedKodePelayanan = prefs.getString('kodePelayanan') ?? '';
    // String savedLoket = prefs.getString('loket') ?? '';
    String savedCreatedAt = prefs.getString('createdAt') ?? '';
    String savedUpdatedAt = prefs.getString('updatedAt') ?? '';

    Ql.logT(
        "kode :$kode, time created :$timeCreated time update: $timeUpdate loket: $loket save pelayanan: $savedKodePelayanan");

    Ql.logFatal(
        "kode pelayanan $savedKodePelayanan, created at : $savedCreatedAt, updated at : $savedUpdatedAt");
    if (kode != savedKodePelayanan) {
      debugPrint("kode: Data baru");
      await playSoundFromCode(kode, loket);
    } else {
      debugPrint("new time $timeCreated, current time $savedCreatedAt");
      if (timeCreated == savedCreatedAt) {
        if (timeUpdate != savedUpdatedAt) {
          debugPrint("kode: recall di panggil ");
          await playSoundFromCode(kode, loket);
        } else {
          debugPrint("logic tidak sama berjalan");
        }
      } else {
        debugPrint("kode tidak berjalan karna time created nya tidak sama");
      }
    }
  }

  //untuk memutar suara
  Future<void> playSoundFromCode(String code, String loket) async {
    final player = AudioPlayer();

    debugPrint("---------");

    await Future.delayed(const Duration(seconds: 1));
    await player.play(AssetSource("sound/nomor_antrian.mp3"));
    await Future.delayed(const Duration(seconds: 1));
    debugPrint("---------");

    for (int i = 0; i < code.length; i++) {
      final character = code[i];
      debugPrint(character);
      await playSoundForCharacter(character, player);
      await Future.delayed(const Duration(seconds: 1));
    }

    debugPrint("Ke: ${code[0]}");
    if (code[0] == "A") {
      debugPrint("Ke: Teler");
      String lastCharackter = loket[loket.length - 1];
      debugPrint("last charakter: $lastCharackter");
      await player.play(AssetSource("sound/ke_teler.mp3"));
      await Future.delayed(const Duration(seconds: 1));
      await player.play(AssetSource("sound/$lastCharackter.mp3"));
      await Future.delayed(const Duration(seconds: 1));
    } else if (code[0] == "B") {
      debugPrint("Ke: Costumer services");
      String lastCharackter = loket[loket.length - 1];
      debugPrint("last charakter: $lastCharackter");
      await player.play(AssetSource("sound/ke_kostumer_services.mp3"));
      await Future.delayed(const Duration(seconds: 2));
      await player.play(AssetSource("sound/$lastCharackter.mp3"));
      await Future.delayed(const Duration(seconds: 1));
    }
    await player.dispose();
    debugPrint("function stop");
  }

  //untum memulai suara berdasarkan list;
  Future<void> playSoundForCharacter(
      String character, AudioPlayer player) async {
    final soundMap = {
      'a': "sound/a.mp3",
      'b': "sound/b.mp3",
      '0': "sound/0.mp3",
      '1': "sound/1.mp3",
      '2': "sound/2.mp3",
      '3': "sound/3.mp3",
      '4': "sound/4.mp3",
      '5': "sound/5.mp3",
      '6': "sound/6.mp3",
      '7': "sound/7.mp3",
      '8': "sound/8.mp3",
      '9': "sound/9.mp3",
    };

    if (soundMap.containsKey(character.toLowerCase())) {
      await player.play(AssetSource(soundMap[character.toLowerCase()]!));
    }
  }

  //untuk putar video youtube
  final YoutubePlayerController ytcontroller = YoutubePlayerController(
    initialVideoId: YoutubePlayer.convertUrlToId(
            "https://www.youtube.com/watch?v=z_6GOFw1XrQ") ??
        "z_6GOFw1XrQ",
    flags: const YoutubePlayerFlags(autoPlay: true, mute: false, loop: true),
  );
}
