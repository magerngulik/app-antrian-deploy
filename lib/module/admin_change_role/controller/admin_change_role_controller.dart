import 'package:antrian_app/core.dart';
import 'package:antrian_app/module/admin_change_role/data/costumer_layar_services.dart';
import 'package:antrian_app/shared/services/m_dialog_confirm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/admin_change_role_view.dart';

class AdminChangeRoleController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getActiceRoleToday();
  }

  AdminChangeRoleView? view;

  List<Map<String, dynamic>> listRoles = [];

  getActiceRoleToday() async {
    var services = ChangeRoleToday();
    var data = await services.getRoles();

    data.fold((l) {
      Get.dialog(MDialogError(
          onTap: () {
            Get.back();
          },
          message: "Error pada server: $l"));
    }, (r) {
      listRoles = r;
      debugPrint("List role: ${listRoles.length}");
      update();
    });
  }

  deleteRoleToday(int id) async {
    var services = ChangeRoleToday();
    var data = await services.deleteRoles(id);

    Get.dialog(MDialogConfirm(
        onTap: () {
          data.fold((l) {
            Get.dialog(MDialogError(
                onTap: () {
                  Get.back();
                  Get.back();
                },
                message: l));
          }, (r) {
            var message = r['message'];
            Get.dialog(MDialogSuccess(
                onTap: () {
                  Get.back();
                  Get.back();
                  getActiceRoleToday();
                  update();
                },
                message: message));
          });
        },
        message: "apakah anda yakin ingin menghapus data ini?"));
  }
}
