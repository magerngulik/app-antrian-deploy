import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<void> saveSingleDataString(
      {required String key, required String value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint("data sebelum di simpan: \n key:$key, \n value: $value");
    if (prefs.containsKey('token')) {
      prefs.remove('token');
      await prefs.setString(key, value);
    }
  }

  static Future<String?> getSingleDataString({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint("Mengambil data dengan key: $key");

    if (prefs.containsKey(key)) {
      return prefs.getString(key);
    } else {
      return null; // Return null if the key is not found
    }
  }

  static Future<int?> getSingleDataInt({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint("Mengambil data dengan key: $key");

    if (prefs.containsKey(key)) {
      return prefs.getInt(key);
    } else {
      return null; // Return null if the key is not found
    }
  }

  static Future<void> saveSingleDataInt(
      {required String key, required int value}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint("data sebelum di simpan: \n key:$key, \n value: $value");
    if (prefs.containsKey('token')) {
      prefs.remove('token');
    }
    await prefs.setInt(key, value);
  }

  static Future<void> saveDataToSharedPreferences(
      Map<String, dynamic> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint("data sebelum di simpan: $data");

    if (prefs.containsKey('token')) {
      prefs.remove('token');
    }
    if (prefs.containsKey('user_id')) {
      prefs.remove('user_id');
    }
    if (prefs.containsKey('user_name')) {
      prefs.remove('user_name');
    }
    if (prefs.containsKey('user_email')) {
      prefs.remove('user_email');
    }
    if (prefs.containsKey('user_assignment')) {
      prefs.remove('user_assignment');
    }
    if (prefs.containsKey('user_layanan')) {
      prefs.remove('user_layanan');
    }
    if (prefs.containsKey('user_unit')) {
      prefs.remove('user_unit');
    }

    await prefs.setString('token', data['token']);
    await prefs.setInt('user_id', data['user']['id']);
    await prefs.setString('user_name', data['user']['name']);
    await prefs.setString('user_email', data['user']['email']);

    if (data['user']['assignment'] != null) {
      await prefs.setInt('user_assignment', data['user']['assignment']);
      await prefs.setString('user_layanan', data['user']['layanan']);
      await prefs.setString('user_unit', data['user']['unit']);
    }
  }

  static Future<Map<String, dynamic>> fetchDataFromSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    int? userId = prefs.getInt('user_id');
    String? userName = prefs.getString('user_name');
    String? userEmail = prefs.getString('user_email');
    int? userAssignment = prefs.getInt('user_assignment');
    String? userLayanan = prefs.getString('user_layanan');
    String? userUnit = prefs.getString('user_unit');

    Map<String, dynamic> userData = {
      'token': token,
      'user': {
        'id': userId,
        'name': userName,
        'email': userEmail,
        'assignment': userAssignment,
        'user_layanan': userLayanan,
        'user_unit': userUnit,
      },
    };

    debugPrint('Token: ${userData['token']}');
    debugPrint('User ID: ${userData['user']['id']}');
    debugPrint('User Name: ${userData['user']['name']}');
    debugPrint('User Email: ${userData['user']['email']}');
    debugPrint('User Assignment: ${userData['user']['assignment']}');
    debugPrint('User userLayanan: ${userData['user']['user_layanan']}');
    debugPrint('User Assignment: ${userData['user']['user_unit']}');

    return userData;
  }
}
