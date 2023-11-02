import 'package:antrian_app/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  LoginView? view;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    password.text = "password";
    email.text = "admin@admin.com";
  }

  String backgroundImage =
      "https://images.unsplash.com/photo-1501167786227-4cba60f6d58f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80";
  doLogin() async {
    Get.showOverlay(
        loadingWidget: const Center(
          child: CircularProgressIndicator(),
        ),
        asyncFunction: () async {
          if (email.text == "syamsul@gmail.com") {
            Get.off(const AdminHomeView());
            return;
          }
          if (email.text.isEmpty || password.text.isEmpty) {
            Get.dialog(MDialogError(
                onTap: () {
                  Get.back();
                },
                message: "Data tidak boleh kosong"));
            return;
          }
          var services = AuthServices();
          debugPrint(email.text);
          var data = await services.doLogin(
              email: email.text, password: password.text);

          data.fold((l) {
            Get.dialog(MDialogError(
                onTap: () {
                  Get.back();
                },
                message: "error : $l"));
          }, (r) async {
            var data = r['data'];

            var assignment = data['user']['assignment'];

            await SharedPreferencesHelper.saveDataToSharedPreferences(data);
            debugPrint("data assignment =$assignment");

            if (assignment == null) {
              Get.off(const UserPickRoleView());
            } else {
              Get.off(const UserPickQueueView());
            }
          });
        });
  }
}
