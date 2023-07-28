import 'package:diary/styles/app_theme.dart';
import 'package:diary/ui/router/router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class App extends HookConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final theme = ref.watch(appThemeProvider);

    return MaterialApp.router(
      routerConfig: router,
      theme: theme.data,
    );
  }
}
