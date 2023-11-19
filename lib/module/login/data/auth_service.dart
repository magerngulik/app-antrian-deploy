import 'package:antrian_app/main.dart';
import 'package:antrian_app/shared/services/m_base_url.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthServices {
  doLogin({required String email, required String password}) async {
    debugPrint("email => $email");
    debugPrint("password => $password");
    try {
      await supabase.auth.signInWithPassword(password: password, email: email);
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

  Future<Either<String, Map<String, dynamic>>> doRegister({
    required String name,
    required String email,
    required String password,
    required String tanggalLahir,
    required String alamat,
    required String nomorTelp,
  }) async {
    try {
      var response = await Dio().post(
        "http://attendance-app.test/api/auth/register",
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
        data: {
          "name": name,
          "email": email,
          "password": password,
          "tanggal_lahir": tanggalLahir,
          "alamat": alamat,
          "nomor_telp": nomorTelp,
        },
      );
      Map<String, dynamic> obj = response.data;
      return Right(obj);
    } on DioException catch (e) {
      if (e.response!.statusCode == 422) {
        final errorMessages = [];

        e.response!.data["errors"].forEach((field, errors) {
          final errorMessage = "$field: ${errors.join(', ')}";
          errorMessages.add(errorMessage);
        });
        final errorString = errorMessages.join('\n');
        return Left(errorString);
      }
      return Left(e.toString());
    }
  }
}
