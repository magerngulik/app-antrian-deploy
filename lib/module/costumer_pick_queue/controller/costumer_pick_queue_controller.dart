import 'dart:async';

import 'package:antrian_app/core.dart';
import 'package:antrian_app/main.dart';
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
  late DateTime currentTime;
  late Timer timer;
  late AnimationController controllerAnimate;

  int selectedService = 1;
  var isLoading = false.obs;

  String getCurrentTime(DateTime time) {
    return DateFormat('HH:mm:ss', "id_ID").format(time);
  }

  getServices() async {
    await Future.delayed(const Duration(seconds: 1));
    Get.showOverlay(
        asyncFunction: () async {
          try {
            final dataGet = await supabase.from('code_queues').select('*');
            Ql.logInfo(data);
            data = dataGet;
          } catch (e) {
            Get.dialog(MDialogError(
                onTap: () {
                  Get.back();
                },
                message: "Gagal ketika ingin mendapatkan data $e"));
          }
        },
        loadingWidget: const LoadingScreen());
  }

  // getServices() async {
  //   var source = await servicesCostumer.getServices();
  //   source.fold((l) {
  //     Get.snackbar("Opps", "Error: $l", duration: const Duration(seconds: 3));
  //   }, (r) {
  //     data = r['data'];
  //     update();
  //   });
  // }

  String formattedDate =
      DateFormat('EEEE, d MMMM yyyy', "id_ID").format(DateTime.now());

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
    currentTime = DateTime.now();
    // Memulai timer yang memperbarui waktu setiap detik
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      currentTime = DateTime.now();
      update();
    });
  }

  @override
  void dispose() {
    // Mematikan timer ketika widget dihancurkan
    timer.cancel();
    super.dispose();
  }
}
