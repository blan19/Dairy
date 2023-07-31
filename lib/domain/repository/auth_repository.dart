import 'package:diary/data/model/user.dart';
import 'package:diary/foundation/utils/result.dart';

abstract class AuthRepository {
  Future<Result<User>> signIn();
  Future<Result<User>> signUp(String gender, int age);

  Future<Result<void>> withdrawal(String id);

  Future<Result<User>> refreshToken();
}
