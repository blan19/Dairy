import 'package:diary/data/data_source/auth_data_source.dart';
import 'package:diary/data/model/user.dart';
import 'package:diary/data/remote/device_info_helper.dart';
import 'package:diary/data/remote/fcm_helper.dart';
import 'package:diary/domain/repository/auth_repository.dart';
import 'package:diary/foundation/utils/result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authRepositoryProvider = Provider((ref) => AuthRepositoryImpl(ref.read));

class AuthRepositoryImpl implements AuthRepository {
  final dynamic _reader;

  AuthRepositoryImpl(this._reader);

  late final AuthDataSource _authDataSource = _reader(authDataSourceProvider);
  late final FcmHelper _fcmHelper = _reader(fcmHelperProvder);
  late final DeviceInfoHelper _deviceInfoHelper = _reader(deviceInfoProvider);

  @override
  Future<Result<User>> signIn() async {
    final token = await _fcmHelper.getToken();
    final deviceId = await _deviceInfoHelper.getDeviceId();

    return Result.guardFuture(
      () async => await _authDataSource.signIn(
        {
          "token": token,
          'deviceId': deviceId,
        },
      ),
    );
  }

  @override
  Future<Result<User>> signUp(gender, age) async {
    final token = await _fcmHelper.getToken();
    final deviceId = await _deviceInfoHelper.getDeviceId();

    return Result.guardFuture(
      () async => await _authDataSource.signUp(
        {
          "token": token,
          'deviceId': deviceId,
          "gender": gender,
          'age': age,
        },
      ),
    );
  }

  @override
  Future<Result<void>> withdrawal(String id) {
    return Result.guardFuture(() async => await _authDataSource.withdrawal(id));
  }

  @override
  Future<Result<User>> refreshToken() {
    return Result.guardFuture(() async => await _authDataSource.refreshToken());
  }
}
