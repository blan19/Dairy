import 'package:diary/data/data_source/auth_data_source.dart';
import 'package:diary/data/model/user.dart';
import 'package:diary/domain/repository/auth_repository.dart';
import 'package:diary/foundation/utils/result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authRepositoryProvider = Provider((ref) => AuthRepositoryImpl(ref.read));

class AuthRepositoryImpl implements AuthRepository {
  final dynamic _reader;

  AuthRepositoryImpl(this._reader);

  late final AuthDataSource _authDataSource = _reader(authDataSourceProvider);

  @override
  Future<Result<User>> signIn(Map<String, dynamic> data) {
    return Result.guardFuture(() async => await _authDataSource.signIn(data));
  }

  @override
  Future<Result<void>> withdrawal(String id) {
    return Result.guardFuture(() async => await _authDataSource.withdrawal(id));
  }
}
