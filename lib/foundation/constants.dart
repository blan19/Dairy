import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

@immutable
class Constants {
  const Constants._({
    required this.serverBaseUrl,
    required this.firebaseProjectID,
    required this.firebaseStorageBucket,
    required this.firebaseMessagingSenderId,
    required this.firebaseAndroidApiKey,
    required this.firebaseAndroidAppId,
    required this.firebaseIosApiKey,
    required this.firebaseIosAppId,
    required this.firebaseIosBundleId,
    required this.firebaseIosClientId,
  });

  factory Constants() {
    return Constants._(
      serverBaseUrl: dotenv.env['SERVER_BASE_URL']!,
      firebaseProjectID: dotenv.env['FIREBASE_PROJECT_ID']!,
      firebaseStorageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET']!,
      firebaseMessagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
      firebaseIosApiKey: dotenv.env['FIREBASE_IOS_API_KEY']!,
      firebaseIosAppId: dotenv.env['FIREBASE_IOS_APP_ID']!,
      firebaseIosBundleId: dotenv.env['FIREBASE_IOS_BUNDLE_ID']!,
      firebaseIosClientId: dotenv.env['FIREBASE_IOS_CLIENT_ID']!,
      firebaseAndroidApiKey: dotenv.env['FIREBASE_ANDROID_API_KEY']!,
      firebaseAndroidAppId: dotenv.env['FIREBASE_ANDROID_APP_ID']!,
    );
  }

  static final Constants instance = Constants();

  final String serverBaseUrl;

  final String firebaseProjectID;
  final String firebaseStorageBucket;
  final String firebaseMessagingSenderId;

  final String firebaseIosApiKey;
  final String firebaseIosAppId;
  final String firebaseIosClientId;
  final String firebaseIosBundleId;

  final String firebaseAndroidApiKey;
  final String firebaseAndroidAppId;
}
