import 'package:diary/data/repository/auth_repository_impl.dart';
import 'package:diary/data/repository/storage_repository.dart';
import 'package:diary/domain/repository/auth_repository.dart';
import 'package:diary/domain/repository/storage_repository.dart';
import 'package:diary/foundation/constants.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dioProvider = Provider((ref) => AppDio.getInstance(ref.read));

class AppDio with DioMixin implements Dio {
  AppDio._({BaseOptions? options, dynamic reader}) {
    options = BaseOptions(
      baseUrl: Constants.instance.serverBaseUrl,
      contentType: 'application/json',
      connectTimeout: const Duration(milliseconds: 30000),
      sendTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
    );

    this.options = options;

    if (kDebugMode) {
      interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    }

    interceptors.add(TokenInterceptor(reader));

    httpClientAdapter = IOHttpClientAdapter();
  }

  static Dio getInstance(dynamic reader) => AppDio._(reader: reader);
}

class RequestInfo {
  String _path = "";
  String _method = "";
  Map<String, dynamic> _query = {};

  RequestInfo._();

  factory RequestInfo() {
    return _instance;
  }

  String get path => _path;
  String get method => _method;
  Map<String, dynamic> get query => _query;

  void update({
    required String path,
    required String method,
    required Map<String, dynamic> query,
  }) {
    _path = path;
    _method = method;
    _query = query;
  }

  static final RequestInfo _instance = RequestInfo._();
}

class TokenInterceptor extends Interceptor {
  final dynamic _reader;

  TokenInterceptor(this._reader);

  late final Dio _dio = Dio();
  late final StorageRepository _storageRepository =
      _reader(storageRepositoryImpl);
  late final AuthRepository _authRepository = _reader(authRepositoryProvider);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers['ACCESS_TOKEN'] == "true") {
      options.headers.remove("ACCESS_TOKEN");

      final user = await _storageRepository.getStorage().then((result) {
        return result.when(success: (user) => user, failure: (_) => null);
      });

      if (options.headers['REFRESH_TOKEN'] == "true") {
        options.headers.remove("REFRESH_TOKEN");
        options.headers.addAll({"REFRESH_TOKEN": user?.refreshToken});
      }

      options.headers.addAll({"ACCESS_TOKEN": user?.accessToken});
    }

    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final isStatus421 = err.response?.statusCode == 421;
    final isStatus422 = err.response?.statusCode == 422;
    final isStatus423 = err.response?.statusCode == 423;
    final isPathRefresh = err.requestOptions.path == "/member/token/refresh";
    RequestOptions options = err.requestOptions;
    final ins = RequestInfo();

    if (isStatus421 && !isPathRefresh) {
      ins.update(
        path: options.path,
        query: options.queryParameters,
        method: options.method,
      );
      final user = await _authRepository.refreshToken().then(
        (result) {
          return result.when(
            success: (data) => data,
            failure: (_) => null,
          );
        },
      );

      if (user == null) return;

      options.headers.addAll({"ACCESS_TOKEN": user.accessToken});
      await _storageRepository.writeStorageUser(user);
    }

    if ((isStatus423 && !isPathRefresh) || isStatus422) {
      final user = await _authRepository.signIn().then(
        (result) {
          return result.when(
            success: (data) => data,
            failure: (_) => null,
          );
        },
      );

      if (user == null) return;

      await _storageRepository.writeStorageUser(user);

      options = options.copyWith(
        path: ins.path,
        queryParameters: ins.query,
        method: ins.method,
      );
      options.headers.addAll({"ACCESS_TOKEN": user.accessToken});
    }

    final res = await _dio.fetch(options);

    return handler.resolve(res);
  }
}
