import 'package:diary/data/model/user.dart';
import 'package:diary/foundation/utils/result.dart';

abstract class AuthRepository {
  Future<Result<User>> signIn(Map<String, dynamic> data);

  Future<Result<void>> withdrawal(String id);
}
