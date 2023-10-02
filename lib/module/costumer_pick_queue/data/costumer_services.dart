import 'package:antrian_app/shared/services/m_base_url.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CostumerServices {
  Future<Either<String, Map<String, dynamic>>> getServices() async {
    String url = costumerServices;
    try {
      var response = await Dio().get(
        url,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
      Map<String, dynamic> obj = response.data;
      debugPrint(obj.toString());
      return Right(obj);
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          return Left(e.response!.data['message']);
        }
        debugPrint(e.response!.statusMessage);
        debugPrint(e.response!.data);
      }
      return Left(e.toString());
    }
  }

  Future<Either<String, Map<String, dynamic>>> getTicketQueue(int id) async {
    String url = costumerPickQueue;
    debugPrint("$url/$id");

    debugPrint("ini url = $url");
    try {
      var response = await Dio().get(
        "$url/$id",
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
      Map<String, dynamic> obj = response.data;
      debugPrint(obj.toString());
      return Right(obj);
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          return Left(e.response!.data['message']);
        } else if (e.response!.statusCode == 404) {
          return Left(e.response!.data['message']);
        }
        debugPrint(e.response!.statusMessage);
        debugPrint(e.response!.data);
      }
      return Left(e.toString());
    }
  }
}
