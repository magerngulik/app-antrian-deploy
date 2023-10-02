import 'package:antrian_app/module/costumer_pick_queue/data/costumer_services.dart';
import 'package:antrian_app/shared/util/q_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/costumer_pick_queue_view.dart';

class CostumerPickQueueController extends GetxController {
  CostumerPickQueueView? view;
  List data = [];
  var servicesCostumer = CostumerServices();
  String namaInstansi = "Bank ABC";
  String layananBuka = "08:00";
  String layananTutup = "15:00";
  String backgroundImage =
      "https://images.unsplash.com/photo-1501167786227-4cba60f6d58f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80";
  final colorManager = ColorManager();

  int selectedService = 1;

  getServices() async {
    var source = await servicesCostumer.getServices();
    source.fold((l) {
      Get.snackbar("Opps", "Error: $l", duration: const Duration(seconds: 3));
    }, (r) {
      data = r['data'];
      update();
    });
  }

  getTicketQueue(int index) async {

    var source = await servicesCostumer.getTicketQueue(index);
    source.fold((l) {
      Get.snackbar("Opps", "Error: $l", duration: const Duration(seconds: 3));
    }, (r) {
      var sourceS = r;
      String kode = sourceS['kode'];
      Get.defaultDialog(
        title: 'Berhasil Mendapatkan Ticket',
        middleText: kode,
        textConfirm: 'Kembali',
        onConfirm: () {
          Get.back();
        },
      );
    });
  }

  @override
  void onInit() {
    super.onInit();
    getServices();
  }
}
