import 'package:diary/data/model/user.dart';
import 'package:diary/foundation/utils/result.dart';

abstract class StorageRepository {
  Future<Result<User?>> getStorage();

  Future<Result<void>> writeStorageUser(User user);

  Future<Result<void>> deleteStorageUser();
}
