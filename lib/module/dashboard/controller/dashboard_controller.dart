import 'package:antrian_app/shared/services/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view/dashboard_view.dart';

class DashboardController extends GetxController {
  DashboardView? view;
  bool isLoading = false;
  Map? totalUser;
  List<Map<String, dynamic>> listCounter = [
    {
      "no_counter": 1,
      "operator_counter": 'Andre',
      'total_antrian': 24,
    },
    {
      "no_counter": 2,
      "operator_counter": 'Andi',
      'total_antrian': 46,
    },
    {
      "no_counter": 3,
      "operator_counter": 'Sendi',
      'total_antrian': 3,
    }
  ];

  Color getColorForQueue(int totalAntrian) {
    if (totalAntrian < 10) {
      return Colors.green; // Jika kurang dari 10, warna hijau
    } else if (totalAntrian < 40) {
      return Colors.yellow; // Jika kurang dari 40, warna kuning
    } else {
      return Colors.red; // Lebih dari atau sama dengan 40, warna merah
    }
  }

  @override
  void onInit() {
    super.onInit();
    getTotalUser();
  }

  getTotalUser() async {
    isLoading = true;
    try {
      totalUser = await SupabaseSevice().getTotalUser();
      isLoading = false;
    } catch (e) {
      print(e);
      isLoading = false;
    }
    print(totalUser);
    update();
  }
}
