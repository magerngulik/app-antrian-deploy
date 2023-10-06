import 'package:antrian_app/core.dart';
import 'package:antrian_app/module/layar/data/costumer_layar_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/layar_view.dart';

class LayarController extends GetxController {
  LayarView? view;
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onClose() {
    // Ini akan dipanggil ketika controller dihapus dari memori
    // Lakukan pembersihan atau pengaturan ulang di sini
    super.onClose();
  }

  var services = CostumerLayarServices();
  List<Map<String, dynamic>> dataList = [];
  String kodePelayanan = "-";
  String loket = "-";

  getData() async {
    var data = await services.viewQueue();
    data.fold((l) {
      Get.dialog(MDialogError(
          onTap: () {
            Get.back();
          },
          message: "error :$l"));
    }, (r) {
      debugPrint(r.toString());
      if (r['data'] == null) {
        debugPrint("data kosong");
        Get.dialog(MDialogSuccess(
            onTap: () {
              Get.back();
            },
            message: r['message']));
      } else {
        var lastData = r['data']['last'];
        for (var item in r['data']['user_aktif']) {
          if (item is Map<String, dynamic>) {
            dataList.add(item);
          }
        }
        kodePelayanan = lastData['kode'];
        loket = lastData['nama_role'];
        update();
      }
    });
  }
}
