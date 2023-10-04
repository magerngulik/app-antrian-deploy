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
    // debugPrint("url: $baseUrl/chose-assignment");
    debugPrint("url get pick assignment=> $getPickAssigment");
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
}
