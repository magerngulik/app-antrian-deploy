import 'package:antrian_app/main.dart';
import 'package:antrian_app/shared/services/m_base_url.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class RoleServices {
  Logger log = Logger();

  Future<Either<String, List<Map<String, dynamic>>>> getRoleUser() async {
    try {
      var response = await Dio().get(
        getRoleUserUrl,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data['data'];
        List<Map<String, dynamic>> roles = [];

        for (var item in responseData) {
          if (item is Map<String, dynamic>) {
            roles.add(item);
          }
        }

        return Right(roles);
      } else {
        return const Left("Failed to fetch data");
      }
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Map<String, dynamic>>> pickRole(
      {required int idUser, required int roleUser}) async {
    try {
      var response = await Dio().post(
        getPickAssigment,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        data: {"id": idUser, "roles": roleUser},
      );
      Map<String, dynamic> obj = response.data;
      debugPrint(obj.toString());
      return Right(obj);
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          return Left(e.response!.data['message']);
        }
      }
      return Left(e.toString());
    }
  }

  static Future getSupaAssignmentToday() async {
    DateTime now = DateTime.now();

    // Menetapkan jam, menit, detik, dan milidetik ke nilai awal hari
    DateTime startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);

    // Menetapkan jam, menit, detik, dan milidetik ke nilai akhir hari
    DateTime endOfDay =
        DateTime(now.year, now.month, now.day, 23, 59, 59, 999, 999);

    final data = await supabase
        .from('assignments')
        .select('id,role_users_id,user_id')
        .gte('created_at', startOfDay.toUtc())
        .lt('created_at', endOfDay.toUtc());
    return data;
  }
}
