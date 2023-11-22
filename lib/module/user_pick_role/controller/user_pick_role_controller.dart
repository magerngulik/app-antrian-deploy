import 'package:antrian_app/core.dart';
import 'package:antrian_app/main.dart';
import 'package:antrian_app/shared/services/m_logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    // getUser();
  }

  loadRole() async {
    LoggerService.logInfo("data user");
    try {
      // var data = await RoleServices.getSupaAssignmentToday();
      var data = await RoleServices.getSupaAssignmentToday();

      List<int> roleUsersIds = data
          .map((map) => map["role_users_id"])
          .whereType<int>() // Hanya ambil yang bertipe int
          .toList();

      // List<int> roleUsersIds = List<int>.from(data['role_users_id']);

      // LoggerService.logError("error", roleUsersIds);

      // Mendapatkan data dari Supabase berdasarkan role_users_id yang diabaikan
      final responseRole = await supabase
          .from('role_users')
          .select('*')
          .not('id', 'in', roleUsersIds)
          .order("created_at", ascending: true);

      LoggerService.logInfo(roleUsersIds);
      LoggerService.logInfo(data);
      LoggerService.logWarning(responseRole);
      dataRole = List<Map<String, dynamic>>.from(responseRole);
      update();
    } on PostgrestException catch (e) {
      if (e.code == 'PGRST116') {
        LoggerService.logInfo(' Data is empty');
        try {
          final responseRole = await supabase
              .from('role_users')
              .select('*')
              .order("created_at", ascending: true);
          dataRole = List<Map<String, dynamic>>.from(responseRole);
          LoggerService.logInfo(responseRole);
          update();
        } catch (e) {
          LoggerService.logError("Gagal mendapatkan data role", e);
        }
      } else {
        Get.defaultDialog(title: "Error", middleText: "Terjadi Error: $e");
        LoggerService.logError("error", e);
      }
    }
  }

  // loadRole() async {
  //   var data = await roleServices.getRoleUser();
  //   data.fold((l) {
  //     Get.back();
  //   }, (r) {
  //     dataRole = r;
  //   });
  //   log.d(dataRole);
  //   update();
  // }

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
