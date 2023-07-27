import 'dart:async';

import 'package:diary/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runZonedGuarded(
    () {
      runApp(const ProviderScope(child: App()));
    },
    (error, stack) {
      print(error);
    },
  );
}
