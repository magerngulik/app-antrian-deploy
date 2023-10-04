import 'package:antrian_app/core.dart';
import 'package:antrian_app/module/user_pick_role/data/role_pick_services.dart';
import 'package:antrian_app/shared/util/q_color.dart';
import 'package:antrian_app/shared/util/q_save_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../view/user_pick_role_view.dart';

class UserPickRoleController extends GetxController {
  UserPickRoleView? view;
  var roleServices = RoleServices();
  var colorServices = ColorManager();
  int selectedIndex = 0;
  int? selectedRole;
  String errorMessage = "";
  List<Map<String, dynamic>> dataRole = [];
  Logger log = Logger();
  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;
  Map<String, dynamic> userData = {};
  int idUser = 0;

  @override
  void onInit() {
    super.onInit();
    loadRole();
    getUser();
  }

  loadRole() async {
    var data = await roleServices.getRoleUser();
    data.fold((l) {
      // rshowDialog("Gagal load data: $l");
    }, (r) {
      dataRole = r;
    });
    log.d(dataRole);
    update();
  }

  pickRole({required int index, required int selectedRoleData}) {
    selectedIndex = index;
    selectedRole = selectedRoleData;
    update();
  }

  checkRole() {
    if (selectedRole == null) {
      Get.dialog(
          MDialogError(onTap: () {}, message: "Pilih role terlebih dahulu"));
      return;
    }
  }

  getUser() async {
    userData = await SharedPreferencesHelper.fetchDataFromSharedPreferences();
    idUser = userData['user']['id'];
  }

  postRole() async {
    if (selectedRole == null) {
      Get.dialog(MDialogError(
          onTap: () {
            Get.back();
          },
          message: "Pilih role terlebih dahulu"));
      return;
    } else if (idUser == 0) {
      Get.dialog(MDialogError(
          onTap: () {
            Get.off(const LoginView());
          },
          message: "Pilih role terlebih dahulu"));
    }

    Get.showOverlay(
        asyncFunction: () async {
          var data = await roleServices.pickRole(
              idUser: idUser, roleUser: selectedRole!);
          data.fold((l) {
            Get.dialog(MDialogError(onTap: () {}, message: "error: $l"));
          }, (r) {
            log.d(r);
            debugPrint("data success pick role => $r");
            Get.off(const UserPickQueueView());
          });
        },
        loadingWidget: const Center(
          child: CircularProgressIndicator(),
        ));
  }
}
