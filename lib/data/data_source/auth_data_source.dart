import 'package:diary/data/remote/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_data_source.g.dart';

@RestApi()
abstract class AuthDataSource {
  factory AuthDataSource(dynamic reader) =>
      _AuthDataSource(reader(dioProvider));

  @POST("/member/signIn")
  Future<void> signIn(@Body() Map<String, dynamic> data);

  @DELETE("/member/{id}")
  Future<void> withdrawal(@Path() String id);
}
