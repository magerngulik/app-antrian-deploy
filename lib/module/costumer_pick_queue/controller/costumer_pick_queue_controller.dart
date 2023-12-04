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
  var newCode = "";

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

  getTicketQueueSupabase(int id) async {
    debugPrint(id.toString());
    String codeQueue = "";
    try {
      final dataCodeQueue =
          await supabase.from('code_queues').select('*').eq('id', id).single();
      codeQueue = dataCodeQueue['queue_code'];
      Ql.logInfo(dataCodeQueue);
    } catch (e) {
      debugPrint(e.toString());
      return;
    }

    DateTime today = DateTime.now();
    try {
      final dataQueue = await supabase
          .from('queues')
          .select('*')
          .lte('created_at', today.toUtc())
          .like('kode', "%$codeQueue%")
          .order('created_at', ascending: false)
          .limit(1);

      if (dataQueue.isNotEmpty) {
        // Data tidak kosong, Anda dapat mengakses data menggunakan dataQueue.data
        var dataLastQueue = dataQueue[0];

        var kode = dataLastQueue['kode'];
        String lastChar = kode.substring(1);
        int result = int.parse(lastChar) + 1;
        String formattedResult = "";

        if (result < 10) {
          formattedResult = '00$result';
        } else if (result < 100) {
          formattedResult = '0$result';
        } else {
          formattedResult = result.toString();
        }
        newCode = "$codeQueue$formattedResult";

        Map dataUpload = {"kode": newCode, "status": "waiting"};
        await supabase.from('queues').insert(dataUpload);

        Ql.logD(newCode);
        String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
        String formattedTime = DateFormat('HH:mm:ss').format(DateTime.now());

        Get.dialog(MDialogTicket(
          kode: newCode,
          tanggal: formattedDate,
          waktu: formattedTime,
          onTap: () {
            Get.back();
          },
        ));
      } else {
        // Data kosong
        debugPrint('Tidak ada data yang memenuhi kriteria.');
        newCode = "${codeQueue}001";
        Map dataUpload = {"kode": newCode, "status": "waiting"};
        await supabase.from('queues').insert(dataUpload);

        newCode = "";
        String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
        String formattedTime = DateFormat('HH:mm:ss').format(DateTime.now());

        Get.dialog(MDialogTicket(
          kode: newCode,
          tanggal: formattedDate,
          waktu: formattedTime,
          onTap: () {
            Get.back();
          },
        ));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
   
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
