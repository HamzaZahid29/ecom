import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../constants/app_constants.dart';
import '../../services/app_log_service.dart';
import '../../services/shared_prefrences_service.dart';
import '../api_result.dart';

class AppApiClient {
  final Dio _dio;

  AppApiClient()
      : _dio = Dio(BaseOptions(
    baseUrl: "${AppConstants.apiBaseUrl}",
    connectTimeout: const Duration(seconds: 40),
    receiveTimeout: const Duration(seconds: 50),
  )) {
    _dio.interceptors.add(AuthInterceptor());
  }

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

  Future<ApiResult<dynamic>> get(String endpoint,
      {Map<String, dynamic>? queryParams}) async {
    try {
      Response response =
      await _dio.get(endpoint, queryParameters: queryParams);
      print('======> ${response.data['status']}');
      LogService.info("✅ Response: \n $endpoint ${response.data}");

      return Success(response.data);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  /// **PUT Request**
  Future<ApiResult<dynamic>> put(String endpoint, dynamic data) async {
    try {
      Response response = await _dio.put(endpoint, data: data);
      print('======> ${response.data['status']}');
      LogService.info("✅ Response: \n $endpoint ${response.data}");

      return Success(response.data);
    } on DioException catch (e) {
      return _handleError(e);
    }
  }
}

class AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await SharedPrefsService.getAccessToken();

    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      String? refreshToken = await SharedPrefsService.getRefreshToken();
      if (refreshToken != null) {
        try {
          final response = await Dio().post(
            "${AppConstants.apiBaseUrl}api/auth/refresh",
            data: {"refreshToken": refreshToken},
            options: Options(contentType: Headers.jsonContentType),
          );

          LogService.debug('Refreshing tokens $refreshToken \n $response');

          if (response.statusCode == 200 &&
              response.data["status"] == "success") {
            final tokens = response.data["payload"]["tokens"] as List<dynamic>;
            String? newAccessToken;
            String? newRefreshToken;

            for (var token in tokens) {
              if (token.containsKey("accessToken")) {
                newAccessToken = token["accessToken"];
              } else if (token.containsKey("refreshToken")) {
                newRefreshToken = token["refreshToken"];
              }
            }

            if (newAccessToken != null && newRefreshToken != null) {
              await SharedPrefsService.saveTokens(
                  accessToken: newAccessToken, refreshToken: newRefreshToken);

              LogService.info('New Tokens Saved Successfully');
              err.requestOptions.headers['Authorization'] =
              'Bearer $newAccessToken';
              final retryResponse = await Dio().fetch(err.requestOptions);
              return handler.resolve(retryResponse);
            }
          }
        } catch (e) {
          LogService.info('Refreshing tokens $e');
          LogService.error("Token refresh failed", e);
        }
      }
    }
    return handler.next(err);
  }
}
