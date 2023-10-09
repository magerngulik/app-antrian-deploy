import 'package:antrian_app/core.dart';
import 'package:antrian_app/module/user_pick_role/data/role_pick_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      Get.back();
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
      Get.dialog(MDialogError(
          onTap: () {
            Get.back();
          },
          message: "Pilih role terlebih dahulu"));
      return;
    }
  }

  getUser() async {
    userData = await SharedPreferencesHelper.fetchDataFromSharedPreferences();
    idUser = userData['user']['id'];
  }

  userUpdate(
      {required int idAssignment,
      required String layanan,
      required String unit}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_assignment', idAssignment);
    await prefs.setString('user_layanan', layanan);
    await prefs.setString('user_unit', unit);
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
            Get.dialog(MDialogError(
                onTap: () {
                  Get.back();
                },
                message: "error: $l"));
          }, (r) {
            log.d(r);
            userUpdate(
                idAssignment: r['assignment']['id'],
                layanan: r['assignment']['layanan'],
                unit: r['assignment']['unit']);
            Get.off(const UserPickQueueView());
          });
        },
        loadingWidget: const Center(
          child: CircularProgressIndicator(),
        ));
  }
}
