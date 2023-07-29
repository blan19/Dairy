import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:device_info_plus/device_info_plus.dart';

final deviceInfoProvider = Provider((_) => DeviceInfoHelper());

class DeviceInfoHelper {
  DeviceInfoHelper();

  Future<BaseDeviceInfo> getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    return await deviceInfoPlugin.deviceInfo;
  }
}
