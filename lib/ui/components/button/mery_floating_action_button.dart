import 'package:diary/styles/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MeryFloatingActionButton extends ConsumerWidget {
  void Function()? onPressed;

  MeryFloatingActionButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);

    return FloatingActionButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: theme.appColors.white_01,
      onPressed: onPressed,
      child: Icon(
        Icons.mode_edit_rounded,
        color: theme.appColors.black_01,
        size: 24,
      ),
    );
  }
}
