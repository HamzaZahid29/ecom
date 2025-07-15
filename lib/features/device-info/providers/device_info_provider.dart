import 'package:ecom/core/network/api_result.dart';
import 'package:ecom/core/providers/app_base_provider.dart';
import 'package:ecom/features/device-info/respository/device_info_repository.dart';

import '../models/device_info_model.dart';

class DeviceInfoProvider extends ApiBaseProvider {
  DeviceInfoProvider() {
    getDeviceInfo();
  }

  DeviceInfoRepository _deviceInfoRepository = DeviceInfoRepository.instance;
  DeviceInfo? deviceInfo;

  Future<void> getDeviceInfo() async {
    setError(false);
    setLoading(true);
    try {
      final result = await _deviceInfoRepository.getDeviceInfo();
      if (result is Success) {
        deviceInfo = DeviceInfo.fromMap(result.data);
      } else {
        setError(true);
      }
    } catch (e) {
      print(e.toString());
      setError(true);
    } finally {
      setLoading(false);
    }
  }
}
