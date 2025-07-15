import 'dart:async';

import 'package:ecom/core/constants/app_constants.dart';

import '../../../core/network/api_clients/auth_api_client.dart';
import '../../../core/network/api_result.dart';

class AuthRepository {
  final AuthApiClient _apiClient = AuthApiClient();

  AuthRepository._privateConstructor();

  static final AuthRepository instance = AuthRepository._privateConstructor();

  Future<ApiResult> login(String email, String password) async {
    final result = await _apiClient.post('/auth/login', {
      "username": email,
      "password": password,
      "expiresInMins": AppConstants.tokenExpirationInMins,
    });

    if (result is Success) {
      return Success(result.data);
    } else if (result is Failure) {
      return Failure(result.error);
    }

    return Failure("Unknown error occurred.");
  }
}
