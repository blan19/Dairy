import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final fcmProvider = Provider((_) => FirebaseMessaging.instance);
final fcmHelperProvder = Provider((ref) => FcmHelper(ref.read));

class FcmHelper {
  final dynamic _reader;

  FcmHelper(this._reader);

  late final FirebaseMessaging _firemessage = _reader(fcmProvider);

  Future<String?> getToken() async {
    return await _firemessage.getToken();
  }
}
