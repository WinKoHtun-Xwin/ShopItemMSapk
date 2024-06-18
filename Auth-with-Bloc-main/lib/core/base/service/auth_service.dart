import 'dart:io';

import 'package:auth_with_bloc/core/base/model/auth_model.dart';
import 'package:auth_with_bloc/core/base/model/login_model.dart';
import 'package:auth_with_bloc/core/base/service/interface_auth_service.dart';
import 'package:auth_with_bloc/core/constants/enums/network_enums.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../init/cache/tokenProvider.dart';

class AuthService extends IAuthService {
  AuthService(super.dioManager);

  @override
  Future<String?> login({
    required String userName,
    required String password,
  }) async {
    var response = await dioManager.dio.post(
      NetworkEnums.login.path,
      data: LoginModel(
        userName: userName,
        password: password,
      ).toJson(),
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      )
    );

    if (response.statusCode == HttpStatus.ok) {
      return AuthModel.fromJson(response.data).token;
    } else {
      return throw Exception();
    }
  }
}
