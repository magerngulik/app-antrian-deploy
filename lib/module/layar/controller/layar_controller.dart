import 'dart:async';

import 'package:antrian_app/core.dart';
import 'package:antrian_app/module/layar/data/costumer_layar_services.dart';
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
    const Duration duration = Duration(seconds: 10);
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
      // Get.dialog(MDialogError(
      //     onTap: () {
      //       Get.back();
      //     },
      //     message: "error :$l"));
    }, (r) {
      debugPrint(r.toString());
      if (r['data'] == null) {
        debugPrint("data kosong");
        // Get.dialog(MDialogSuccess(
        //     onTap: () {
        //       Get.back();
        //     },
        //     message: r['message']));
      } else {
        var lastData = r['data']['last'];
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
            kode: kodePelayanan, timeCreated: createdAt, timeUpdate: updatedAt);

        saveTemporaryData(
            kode: kodePelayanan, timeCreated: createdAt, timeUpdate: updatedAt);
      }
    });
  }

  saveTemporaryData(
      {required String kode,
      required String timeCreated,
      required String timeUpdate}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('kodePelayanan', kodePelayanan);
    prefs.setString('loket', loket);
    prefs.setString('createdAt', createdAt);
    prefs.setString('updatedAt', updatedAt);
  }

  mVoiceCall(
      {required String kode,
      required String timeCreated,
      required String timeUpdate}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedKodePelayanan = prefs.getString('kodePelayanan') ?? '';
    // String savedLoket = prefs.getString('loket') ?? '';
    String savedCreatedAt = prefs.getString('createdAt') ?? '';
    String savedUpdatedAt = prefs.getString('updatedAt') ?? '';

    if (kode != savedKodePelayanan) {
      debugPrint("kode: Data baru");
    } else {
      if (timeCreated == savedCreatedAt) {
        if (timeUpdate != savedUpdatedAt) {
          debugPrint("kode: Recall di panggil");
          Get.dialog(
              MDialogSuccess(onTap: () {}, message: "recall di panggil"));
        }
      }
    }

    debugPrint("Kode : sebelum = $savedKodePelayanan");
    debugPrint("Kode : sesudah = $kode");
    debugPrint("Kode : created sebelum = $savedCreatedAt");
    debugPrint("Kode : created sesudah = $timeCreated");
    debugPrint("Kode : updateed sebelum = $savedUpdatedAt");
    debugPrint("Kode : updateed sesudah = $timeUpdate");
  }

  final YoutubePlayerController ytcontroller = YoutubePlayerController(
    initialVideoId: YoutubePlayer.convertUrlToId(
            "https://www.youtube.com/watch?v=z_6GOFw1XrQ") ??
        "z_6GOFw1XrQ",
    flags: const YoutubePlayerFlags(autoPlay: true, mute: false, loop: true),
  );
}
