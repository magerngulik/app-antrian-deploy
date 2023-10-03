import 'package:antrian_app/module/costumer_pick_queue/data/costumer_services.dart';
import 'package:antrian_app/shared/services/m_dialog.dart';
import 'package:antrian_app/shared/util/q_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
  var isLoading = false.obs;
  testDialog() {
    // Get.dialog(MDialogTicket(
    //   kode: "A001",
    //   onTap: () {
    //     Get.back();
    //   },
    // ));
  }

  getServices() async {
    var source = await servicesCostumer.getServices();
    source.fold((l) {
      Get.snackbar("Opps", "Error: $l", duration: const Duration(seconds: 3));
    }, (r) {
      data = r['data'];
      update();
    });
  }

  void getTicketQueue(int index) async {
    // Tampilkan loading indicator
    Get.showOverlay(
      asyncFunction: () async {
        var source = await servicesCostumer.getTicketQueue(index);
        // Tampilkan dialog
        source.fold((l) {
          Get.snackbar("Opps", "Error: $l",
              duration: const Duration(seconds: 3));
        }, (r) {
          var sourceS = r;
          String kode = sourceS['kode'];

          DateTime createdAt = DateTime.parse(sourceS['created_at']);

          // Menggunakan pustaka intl untuk memformat tanggal dan waktu
          String formattedDate = DateFormat('yyyy-MM-dd').format(createdAt);
          String formattedTime = DateFormat('HH:mm:ss').format(createdAt);

          Get.dialog(MDialogTicket(
            kode: kode,
            tanggal: formattedDate,
            waktu: formattedTime,
            onTap: () {
              Get.back();
            },
          ));
        });
      },
      loadingWidget: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    getServices();
  }
}
