import 'package:diary/data/model/user.dart';
import 'package:diary/data/repository/auth_repository_impl.dart';
import 'package:diary/data/repository/storage_repository.dart';
import 'package:diary/domain/repository/auth_repository.dart';
import 'package:diary/domain/repository/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final accountViewModelProvider =
    ChangeNotifierProvider((ref) => AccountViewModel(ref.read));

class AccountViewModel extends ChangeNotifier {
  final dynamic _reader;
  String? _gender;
  int? _age;
  String? get gender => _gender;
  int? get age => _age;

  AccountViewModel(this._reader);

  late final AuthRepository _authRepository = _reader(authRepositoryProvider);
  late final StorageRepository _storageRepository =
      _reader(storageRepositoryImpl);

  Future<void> signUp() async {
    final data = await _authRepository.signUp(gender!, age!).then((result) {
      return result.when(
          success: (data) {
            return data;
          },
          failure: (_) => result);
    });

    await _storageRepository.writeStorageUser(data as User);
  }

  void updateGender(gender) {
    _gender = gender;
    notifyListeners();
  }

  void updateAge(age) {
    _age = age;
    notifyListeners();
  }
}
