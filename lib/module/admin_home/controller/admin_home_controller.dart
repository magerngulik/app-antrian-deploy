import 'package:antrian_app/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/admin_home_view.dart';

class AdminHomeController extends GetxController {
  AdminHomeView? view;

  var data = [
    {
      "name": "Report",
      "onclick": Container(),
      "icon": Icons.report,
      "no-services": true
    },
    {
      "name": "Change Roles today",
      "onclick": const AdminChangeRoleView(),
      "icon": Icons.change_circle,
      "no-services": false
    },
  ];

  goto(Widget widget) {
    Get.to(widget);
  }

  get noServices {
    Get.defaultDialog(
        title: "Warning", middleText: "Belum ada fiture yang tersedia");
  }
}
