import 'package:antrian_app/core.dart';
import 'package:antrian_app/main.dart';
import 'package:antrian_app/module/user_pick_queue/data/user_pick_queue_services.dart';
import 'package:antrian_app/shared/services/m_dialog.dart';
import 'package:antrian_app/shared/util/q_save_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../view/user_pick_queue_view.dart';

class UserPickQueueController extends GetxController {
  UserPickQueueView? view;
  //user
  Map<String, dynamic> userData = {};
  String? idUser;
  String token = "";
  String name = "";
  String email = "";
  int assignmentId = 0;
  int roleUserId = 0;
  String layanan = "";
  String unit = "";
  String currentQueue = "-";
  int waitingQueue = 0;
  //services
  UserPickQueueServices services = UserPickQueueServices();
  //error
  String errorMessage = "";
  //success
  Map<String, dynamic> dataRole = {};
  var log = Logger();

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  pickQueue() async {
    var data = await services.pickQueue(assignmentId);
    data.fold((l) {
      Get.dialog(MDialogError(
          onTap: () {
            Get.back();
          },
          message: l));
    }, (r) {
      dataRole = r;
      getCurrentQueue();
      debugPrint("Data Role =$data");
    });
  }

  doLogout() async {
    try {
      await supabase.auth.signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      Get.dialog(const AlertDialogNotif(
          title: "Anda gagal logout",
          srcImages: "assets/images/notif_failed.png"));
    }
  }

  getCurrentQueue() async {
    var data = await services.viewQueue(assignmentId);
    data.fold((l) {
      Get.dialog(MDialogError(
          onTap: () {
            Get.back();
          },
          message: "error : $l"));
      update();
    }, (r) {
      var source = r['data'];
      var queue = source['queue'];
      var waitingCount = source['last_queue'];
      debugPrint("queue: $queue");
      debugPrint("waiting queue = $waitingCount");
      if (queue == null) {
        currentQueue = "-";
      } else {
        var waitingCode = queue['kode'];
        currentQueue = waitingCode;
      }
      waitingQueue = waitingCount;
      update();
    });
  }

//get user yang sedang login
  getUser() async {
    // userData = await SharedPreferencesHelper.fetchDataFromSharedPreferences();
    // idUser = userData['user']['id'];
    // name = userData['user']['name'];
    // email = userData['user']['email'];
    // assignmentId = userData['user']['assignment'];
    // token = userData['token'];
    // layanan = userData['user']['user_layanan'];
    // unit = userData['user']['user_unit'];
    // update();
    // getCurrentQueue();
    // debugPrint("---------------");
    // debugPrint("name:$name");
    // debugPrint("name:$email");
    // debugPrint("name:$assignmentId");
    // debugPrint("---------------");

    if (supabase.auth.currentUser == null) {
      Get.off(const LoginView());
    } else {
      idUser = supabase.auth.currentUser!.id;
      assignmentId = await SharedPreferencesHelper.getSingleDataInt(
              key: "assignment_id") ??
          0;

      roleUserId =
          await SharedPreferencesHelper.getSingleDataInt(key: "role_user_id") ??
              0;

      if (assignmentId == 0 || roleUserId == 0) {
        log.w("assingment id atau role userid tidak di temukan");
        Get.off(const LoginView());
      }
      log.f({
        "assingment id": assignmentId,
        "role user id ": roleUserId,
        "user id": supabase.auth.currentUser!.id
      });
    }
  }

  //menyudahi sessi pelayanan, merubah status dari queue costumer menjadi complete
  confirmQueue() async {
    var data = await services.confirmQueue(assignmentId);
    debugPrint("assignment id = $assignmentId");
    data.fold((l) {
      Get.dialog(MDialogError(
          onTap: () {
            Get.back();
          },
          message: l));
    }, (r) {
      var message = r['message'];
      Get.dialog(MDialogSuccess(
          onTap: () {
            getCurrentQueue();
            Get.back();
          },
          message: message));
      getCurrentQueue();
    });
  }

  //menyudahi sessi pelayanan, merubah status dari queue costumer menjadi complete
  skipQueue() async {
    var data = await services.skipQueue(assignmentId);
    debugPrint("assignment id = $assignmentId");
    data.fold((l) {
      Get.dialog(MDialogError(
          onTap: () {
            Get.back();
          },
          message: l));
    }, (r) {
      var message = r['message'];
      Get.dialog(MDialogSuccess(
          onTap: () {
            getCurrentQueue();
            Get.back();
          },
          message: message));
      getCurrentQueue();
    });
  }

  recallQueue() async {
    var data = await services.recallQueue(assignmentId);
    debugPrint("assignment id = $assignmentId");
    data.fold((l) {
      Get.dialog(MDialogError(
          onTap: () {
            Get.back();
          },
          message: l));
    }, (r) {
      var message = r['message'];
      Get.dialog(MDialogSuccess(
          onTap: () {
            getCurrentQueue();
            Get.back();
          },
          message: message));
      getCurrentQueue();
    });
  }
}
