import 'dart:convert';

import 'package:diary/data/model/user.dart';
import 'package:diary/data/remote/storage_helper.dart';
import 'package:diary/domain/repository/storage_repository.dart';
import 'package:diary/foundation/utils/result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final storageRepositoryImpl =
    Provider((ref) => StorageRepositoryImpl(ref.read));

class StorageRepositoryImpl implements StorageRepository {
  final dynamic _reader;

  StorageRepositoryImpl(this._reader);

  late final StorageHelper _storageHelper = _reader(storageHelperProvider);

  @override
  Future<Result<User?>> getStorage() async {
    return Result.guardFuture(() async {
      return _storageHelper.read("user").then((value) {
        if (value != null && value.isNotEmpty) {
          return User.fromJson(jsonDecode(value));
        }
        return null;
      });
    });
  }

  @override
  Future<Result<void>> writeStorageUser(User user) async {
    return Result.guardFuture(
      () async => await _storageHelper.write(
        "user",
        jsonEncode(user.toJson()),
      ),
    );
  }

  @override
  Future<Result<void>> deleteStorageUser() async {
    return Result.guardFuture(() async => await _storageHelper.delete("user"));
  }
}
