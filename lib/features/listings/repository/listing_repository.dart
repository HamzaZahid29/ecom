import 'dart:async';
import 'package:ecom/core/network/api_clients/app_api_client.dart';
import '../../../core/network/api_result.dart';

class ListingRepository {
  ListingRepository._privateConstructor();

  static final ListingRepository instance =
  ListingRepository._privateConstructor();
  AppApiClient _appApiClient = AppApiClient();

  Future<ApiResult> getProducts({int limit = 10, int skip = 0}) async {
    final result = await _appApiClient.get(
        '/products?limit=$limit&skip=$skip&select=title,price,category,availabilityStatus,rating,thumbnail'
    );

    if (result is Success) {
      return Success(result.data);
    } else if (result is Failure) {
      return Failure(result.error);
    }

    return Failure("Unknown error occurred.");
  }
}