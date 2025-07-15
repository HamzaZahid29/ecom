import 'dart:async';

import 'package:ecom/core/method-channels/method-channel-clients/method_channel_client.dart';

import '../../../core/network/api_result.dart';

class DeviceInfoRepository {
  DeviceInfoRepository._privateConstructor();

  static final DeviceInfoRepository instance =
      DeviceInfoRepository._privateConstructor();
  MethodChannelClient _methodChannelClient = MethodChannelClient();

  Future<ApiResult> getDeviceInfo() async {
    final result = await _methodChannelClient.getDeviceInfo();

    if (result is Success) {
      return Success(result.data);
    } else if (result is Failure) {
      return Failure(result.error);
    }

    return Failure("Unknown error occurred.");
  }
}
