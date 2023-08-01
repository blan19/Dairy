import 'package:diary/styles/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DefaultLayout extends ConsumerWidget {
  final PreferredSizeWidget? appbar;
  final Widget? child;
  final Widget? floatingActionButton;

  const DefaultLayout({
    super.key,
    this.appbar,
    this.child,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);

    if (appbar == null) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: theme.appVar.spacing),
            child: child,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: appbar,
      floatingActionButton: floatingActionButton,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: theme.appVar.spacing),
        child: child,
      ),
    );
  }
}
