import 'package:flutter/services.dart';

import '../../network/api_result.dart';

class MethodChannelClient{
  static const MethodChannel _deviceInfoChannel = MethodChannel('com.example.ecom/device_info');

  Future<ApiResult<dynamic>> getDeviceInfo() async {
    try {
      final Map<Object?, Object?> result = await _deviceInfoChannel.invokeMethod('getDeviceInfo');

      final Map<String, dynamic> deviceInfo = {};
      result.forEach((key, value) {
        if (key is String) {
          deviceInfo[key] = value;
        }
      });

      return Success(deviceInfo);
    } on PlatformException catch (e) {
      return Failure(e.message ?? 'Unexpected Error in fetching device info');
    } catch (e) {
      return Failure('Unexpected Error in fetching device info: $e');
    }
  }
}