import 'package:diary/data/model/user.dart';
import 'package:diary/data/remote/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_data_source.g.dart';

final authDataSourceProvider = Provider((ref) => AuthDataSource(ref.read));

@RestApi()
abstract class AuthDataSource {
  factory AuthDataSource(dynamic reader) =>
      _AuthDataSource(reader(dioProvider));

  @POST("/member/signIn")
  Future<User> signIn(@Body() Map<String, dynamic> data);

  @DELETE("/member/{id}")
  Future<void> withdrawal(@Path() String id);
}
