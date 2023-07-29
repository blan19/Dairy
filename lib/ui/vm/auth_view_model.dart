import 'package:diary/data/model/user.dart';
import 'package:diary/data/repository/auth_repository_impl.dart';
import 'package:diary/data/repository/storage_repository.dart';
import 'package:diary/domain/repository/auth_repository.dart';
import 'package:diary/domain/repository/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authViewModelProvider =
    ChangeNotifierProvider((ref) => AuthViewModel(ref.read));

class AuthViewModel extends ChangeNotifier {
  final dynamic _reader;

  AuthViewModel(this._reader);

  late final AuthRepository _authRepository = _reader(authRepositoryProvider);
  late final StorageRepository _storageRepository =
      _reader(storageRepositoryImpl);

  Future<String?> redirect(BuildContext context, GoRouterState state) async {
    if (state.fullPath == "/splash") {
      final user = await _storageRepository.getStorage().then((result) {
        return result.when(success: (data) => data, failure: (_) => result);
      });
      if (user == null) {
        final data = await _authRepository.signIn().then((result) {
          return result.when(
              success: (data) {
                return data;
              },
              failure: (_) => result);
        });

        await _storageRepository.writeStorageUser(data as User);
        return "/";
      } else {
        return "/";
      }
    }
    return null;
  }
}
