import 'package:antrian_app/constants.dart';
import 'package:antrian_app/models/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  RxBool isDesktop = (Get.size.width >= screenLg).obs;
  MenuItem? menuItem;

  void toggleSideBar() {
    debugPrint('TOGGLING SIDE');

    isDesktop.value = !isDesktop.value;
    update();
  }

  bool get isSmall => !isDesktop.value;

  // RxBool get isDesktop => (Get.size.width >= screenLg).obs;

  void setCurrentItem(MenuItem item) {
    menuItem = item;
  }

  MenuItem? get item => menuItem;
}
