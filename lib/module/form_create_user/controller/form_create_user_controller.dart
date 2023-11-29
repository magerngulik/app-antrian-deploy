import 'package:antrian_app/main.dart';
import 'package:antrian_app/shared/widget/show_loading/dialog/alert_dialog_notif.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../view/form_create_user_view.dart';

class FormCreateUserController extends GetxController {
  FormCreateUserView? view;

  var email = '';
  var password = '';
  createUser() async {
    try {
      final res = await supabase.auth.signUp(password: password, email: email);
      if (res.user != null) {
        Get.dialog(const AlertDialogNotif(
            title: 'Create Succes',
            srcImages: 'assets/images/notif_succes.png'));
        await Future.delayed(const Duration(seconds: 2));
        Get.back(closeOverlays: true);
      }
    } catch (e) {
      print(e);
    }
  }
}
