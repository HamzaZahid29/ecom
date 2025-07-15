import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../constants/app_constants.dart';
import '../../services/app_log_service.dart';
import '../api_result.dart';

class AuthApiClient {
  final Dio _dio;

  AuthApiClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: "${AppConstants.apiBaseUrl}",
          connectTimeout: const Duration(seconds: 40),
          receiveTimeout: const Duration(seconds: 50),
        ),
      );

  /// Handle API Errors
  Failure _handleError(DioException error) {
    if (error.response != null) {
      debugPrintThrottled('======> ${error.response}');
      final responseData = error.response?.data;

      if (responseData is Map<String, dynamic> &&
          responseData.containsKey('message')) {
        LogService.warning(responseData['message']);
        return Failure(responseData['message']); // ✅ Now it properly returns
      }
      // If responseData is not a Map, try extracting error text
      else if (responseData is String) {
        return Failure(responseData);
      }

      return Failure("An unknown server error occurred.");
    } else if (error.type == DioExceptionType.connectionTimeout) {
      return Failure("Connection Timeout. Please try again.");
    } else if (error.type == DioExceptionType.receiveTimeout) {
      return Failure("Receive Timeout. Please try again.");
    } else if (error.type == DioExceptionType.badResponse) {
      return Failure("Bad Response. Something went wrong.");
    } else {
      return Failure("Unexpected error. Please try again.");
    }
  }

  Future<ApiResult<dynamic>> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      Response response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
      );
      print('======> ${response.data['status']}');
      LogService.info("✅ Response: \n $endpoint ${response.data}");

      return Success(response.data);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  /// **POST Request**
  Future<ApiResult<dynamic>> post(
    String endpoint,
    dynamic data, {
    Map<String, dynamic>? files,
  }) async {
    try {
      dynamic requestData;
      Options options = Options();
      requestData = jsonEncode(data);
      options.contentType = Headers.jsonContentType;
      Response response = await _dio.post(
        endpoint,
        data: requestData,
        options: options,
      );
      LogService.info("✅ Response: \n $endpoint ${response.data}");

      return Success(response.data);
    } on DioException catch (e) {
      LogService.error("❌ API Error: $endpoint", e, e.stackTrace);
      return _handleError(e);
    }
  }
}
