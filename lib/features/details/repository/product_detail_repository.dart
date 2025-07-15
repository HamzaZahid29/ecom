import 'dart:async';

import 'package:ecom/core/network/api_clients/app_api_client.dart';

import '../../../../core/network/api_result.dart';

class ProductDetailRepository {
  ProductDetailRepository._privateConstructor();

  static final ProductDetailRepository instance =
      ProductDetailRepository._privateConstructor();
  AppApiClient _appApiClient = AppApiClient();

  Future<ApiResult> getProductDetail(String productId) async {
    final result = await _appApiClient.get('/products/$productId');

    if (result is Success) {
      return Success(result.data);
    } else if (result is Failure) {
      return Failure(result.error);
    }

    return Failure("Unknown error occurred.");
  }
}
