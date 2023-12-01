import 'package:antrian_app/core.dart';
import 'package:antrian_app/main.dart';
import 'package:antrian_app/shared/services/m_logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
  LoginView? view;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String uuid = "f9118c0e-1513-4b36-8b08-23211c9875df";
  // String uuid = "05eb6390-6060-4b70-95da-c69abf05336f";

  @override
  void onInit() {
    super.onInit();
    email.text = 'admin@admin.com';
    // password.text = "123456789";
    password.text = "password";
  }

  String backgroundImage =
      "https://images.unsplash.com/photo-1501167786227-4cba60f6d58f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80";
  // doLogin() async {
  //   Get.showOverlay(
  //       loadingWidget: const Center(
  //         child: CircularProgressIndicator(),
  //       ),
  //       asyncFunction: () async {
  //
  //         }
  //         if (email.text.isEmpty || password.text.isEmpty) {
  //           Get.dialog(MDialogError(
  //               onTap: () {
  //                 Get.back();
  //               },
  //               message: "Data tidak boleh kosong"));
  //           return;
  //         }
  //         var services = AuthServices();
  //         debugPrint(email.text);
  //         var data = await services.doLogin(
  //             email: email.text, password: password.text);

  //         data.fold((l) {
  //           Get.dialog(MDialogError(
  //               onTap: () {
  //                 Get.back();
  //               },
  //               message: "error : $l"));
  //         }, (r) async {
  //           var data = r['data'];

  //           var assignment = data['user']['assignment'];

  //           await SharedPreferencesHelper.saveDataToSharedPreferences(data);
  //           debugPrint("data assignment =$assignment");

  //           if (assignment == null) {
  //             Get.off(const UserPickRoleView());
  //           } else {
  //             Get.off(const UserPickQueueView());
  //           }
  //         });
  //       });
  // }

  doLogin() async {
    try {
      // final startOfDay = DateTime(2023, 11, 19, 0, 0, 0);
      // final endOfDay = DateTime(2023, 11, 19, 23, 59, 59, 999, 999);
      // if (email.text == "admin@admin2.com") {
      //   await supabase.auth.signInWithPassword(
      //     password: password.text,
      //     email: email.text,
      //   );
      //   Get.off(SidebarXExampleApp());
      //   return;
      // }else{
      // }

      await supabase.auth.signInWithPassword(
        password: password.text,
        email: email.text,
      );

      DateTime now = DateTime.now();

      // Menetapkan jam, menit, detik, dan milidetik ke nilai awal hari
      DateTime startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);

      // Menetapkan jam, menit, detik, dan milidetik ke nilai akhir hari
      DateTime endOfDay =
          DateTime(now.year, now.month, now.day, 23, 59, 59, 999, 999);

      if (supabase.auth.currentUser == null) {
        Get.dialog(const AlertDialogNotif(
            title: "Anda belum login silahkan login terlebih dahulu",
            srcImages: 'assets/images/notif_failed.png'));
        return;
      }

      final data = await supabase
          .from('assignments')
          .select('id,role_users_id,user_id')
          .gte('created_at', startOfDay.toUtc())
          .lt('created_at', endOfDay.toUtc())
          .eq('user_id', supabase.auth.currentUser!.id)
          .single();

      if ((data is List && data.isEmpty)) {
        Ql.logInfo(' Data is empty');
        Get.off(const UserPickRoleView());
      } else {
        Ql.logInfo(data);
        // Get.off(const UserPickQueueView());
        String keyValue = "assignment_id";
        int dataVaue = data['id'];
        await SharedPreferencesHelper.saveSingleDataInt(
            key: keyValue, value: dataVaue);

        await SharedPreferencesHelper.saveSingleDataInt(
            key: "role_user_id", value: data['role_users_id']);
        // Lakukan sesuatu dengan data yang ditemukan
        Get.off(const UserPickQueueView());
      }

      // LoggerService.logInfo(data);
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        Ql.logInfo(' Data is empty');
        Get.off(const UserPickRoleView());
      } else {
        Get.defaultDialog(title: "Error", middleText: "Terjadi Error: $e");
        Ql.logError("error", e);
      }
    }
  }
}
