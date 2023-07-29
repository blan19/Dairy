import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storageProvider = Provider((ref) => const FlutterSecureStorage());

final storageHelperProvider = Provider((ref) => StorageHelper(ref.read));

class StorageHelper {
  final dynamic _reader;

  StorageHelper(this._reader);

  late final FlutterSecureStorage _secureStorage = _reader(storageProvider);

  Future<String?> read(String key) async {
    return await _secureStorage.read(key: key);
  }

  Future<void> write(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }
}
