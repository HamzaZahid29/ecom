class DeviceInfo {
  final String deviceModel;
  final String systemName;
  final String systemVersion;
  final String deviceName;
  final String appVersion;
  final String buildNumber;
  final bool isPhysicalDevice;

  DeviceInfo({
    required this.deviceModel,
    required this.systemName,
    required this.systemVersion,
    required this.deviceName,
    required this.appVersion,
    required this.buildNumber,
    required this.isPhysicalDevice,
  });

  factory DeviceInfo.fromMap(Map<String, dynamic> map) {
    return DeviceInfo(
      deviceModel: map['deviceModel'] ?? 'Unknown',
      systemName: map['systemName'] ?? 'Unknown',
      systemVersion: map['systemVersion'] ?? 'Unknown',
      deviceName: map['deviceName'] ?? 'Unknown',
      appVersion: map['appVersion'] ?? 'Unknown',
      buildNumber: map['buildNumber'] ?? 'Unknown',
      isPhysicalDevice: map['isPhysicalDevice'] ?? false,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'deviceModel': deviceModel,
      'systemName': systemName,
      'systemVersion': systemVersion,
      'deviceName': deviceName,
      'appVersion': appVersion,
      'buildNumber': buildNumber,
      'isPhysicalDevice': isPhysicalDevice,
    };
  }

  @override
  String toString() {
    return 'DeviceInfo(deviceModel: $deviceModel, systemName: $systemName, systemVersion: $systemVersion, deviceName: $deviceName, appVersion: $appVersion, buildNumber: $buildNumber, isPhysicalDevice: $isPhysicalDevice)';
  }
}