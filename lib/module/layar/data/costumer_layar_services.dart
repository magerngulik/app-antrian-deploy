import 'package:antrian_app/shared/services/m_base_url.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class CostumerLayarServices {
  Logger log = Logger();

  Future<Either<String, Map<String, dynamic>>> viewQueue() async {
    try {
      var response = await Dio().get(
        viewQueueUserUrl,
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        return Right(responseData);
      } else {
        return const Left("Failed to fetch data");
      }
    } on DioException catch (e) {
      if (e.response != null) {
        debugPrint("status code ${e.response!.statusCode.toString()}");
        if (e.response!.statusCode == 401) {
          return Left(e.response!.data['message']);
        } else if (e.response!.statusCode == 404) {
          return Left(e.response!.data['message']);
        } else if (e.response!.statusCode == 400) {
          return Left(e.response!.data['message']);
        } else {
          return Left(e.response!.statusCode.toString());
        }
      }
      return Left(e.toString());
    }
  }
}
