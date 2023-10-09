import 'dart:async';

import 'package:antrian_app/core.dart';
import 'package:antrian_app/module/layar/data/costumer_layar_services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../view/layar_view.dart';

class LayarController extends GetxController {
  LayarView? view;
  @override
  void onInit() {
    super.onInit();
    getDataOnce();
    startDataFetching();
  }

  @override
  void onClose() {
    super.onClose();
    stopDataFetching();
  }

  var services = CostumerLayarServices();
  List<Map<String, dynamic>> dataList = [];
  String kodePelayanan = "-";
  String loket = "-";
  String createdAt = "";
  String updatedAt = "";
  Timer? dataTimer;

  void startDataFetching() {
    const Duration duration = Duration(seconds: 15);
    dataTimer = Timer.periodic(duration, (Timer timer) {
      getData(); // Panggil fungsi getData setiap 5 detik
    });
  }

  void stopDataFetching() {
    dataTimer?.cancel(); // Hentikan timer jika diperlukan
  }

  void getDataOnce() async {
    await getData();
  }

  getData() async {
    debugPrint("di panggil ulang");
    var data = await services.viewQueue();
    data.fold((l) {
      debugPrint("error: $l");
    }, (r) {
      debugPrint(r.toString());
      if (r['data'] == null) {
        debugPrint("data kosong");
      } else {
        var lastData = r['data']['last'];
        dataList.clear();
        for (var item in r['data']['user_aktif']) {
          if (item is Map<String, dynamic>) {
            dataList.add(item);
          }
        }
        kodePelayanan = lastData['kode'];
        loket = lastData['nama_role'];
        createdAt = lastData['created_at'];
        updatedAt = lastData['updated_at'];
        update();
        debugPrint("created_at: $createdAt");

        mVoiceCall(
            kode: kodePelayanan,
            timeCreated: createdAt,
            timeUpdate: updatedAt,
            loket: loket);

        saveTemporaryData(
            kode: kodePelayanan, timeCreated: createdAt, timeUpdate: updatedAt);
      }
    });
  }

  saveTemporaryData({
    required String kode,
    required String timeCreated,
    required String timeUpdate,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('kodePelayanan', kodePelayanan);
    prefs.setString('loket', loket);
    prefs.setString('createdAt', createdAt);
    prefs.setString('updatedAt', updatedAt);
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

    if (kode != savedKodePelayanan) {
      debugPrint("kode: Data baru");
      await playSoundFromCode(kode, loket);
    } else {
      if (timeCreated == savedCreatedAt) {
        if (timeUpdate != savedUpdatedAt) {
          debugPrint("kode: Recall di panggil");
          await playSoundFromCode(kode, loket);
        }
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
