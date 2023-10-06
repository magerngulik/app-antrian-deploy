import 'package:antrian_app/module/user_pick_queue/data/user_pick_queue_services.dart';
import 'package:antrian_app/shared/services/m_dialog.dart';
import 'package:antrian_app/shared/util/q_save_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/user_pick_queue_view.dart';

class UserPickQueueController extends GetxController {
  UserPickQueueView? view;
  //user
  Map<String, dynamic> userData = {};
  int idUser = 0;
  String token = "";
  String name = "";
  String email = "";
  int assignmentId = 0;
  String layanan = "";
  String unit = "";
  String currentQueue = "-";
  //services
  UserPickQueueServices services = UserPickQueueServices();
  //error
  String errorMessage = "";
  //success
  Map<String, dynamic> dataRole = {};

  @override
  void onInit() {
    super.onInit();
    getUser();
    getCurrentQueue();
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

  getCurrentQueue() async {
    var data = await services.viewQueue(assignmentId);
    data.fold((l) {
      Get.dialog(MDialogError(
          onTap: () {
            Get.back();
          },
          message: "error : $l"));
      currentQueue = "-";
    }, (r) {
      var source = r;
      var lastData = source['last']['kode'];
      currentQueue = lastData;
    });
    update();
  }

  getUser() async {
    userData = await SharedPreferencesHelper.fetchDataFromSharedPreferences();
    idUser = userData['user']['id'];
    name = userData['user']['name'];
    email = userData['user']['email'];
    assignmentId = userData['user']['assignment'];
    token = userData['token'];
    layanan = userData['user']['user_layanan'];
    unit = userData['user']['user_unit'];
    update();
  }
}
