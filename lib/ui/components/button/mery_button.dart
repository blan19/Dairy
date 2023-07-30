import 'package:diary/styles/app_theme.dart';
import 'package:diary/styles/app_theme_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MeryButton extends ConsumerWidget {
  String text;
  bool primary;
  void Function()? callback;

  MeryButton({
    super.key,
    required this.text,
    this.callback,
    this.primary = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);

    return GestureDetector(
      onTap: callback,
      child: Container(
        width: primary ? double.infinity : null,
        decoration: BoxDecoration(
          color: primary ? theme.appColors.primary : theme.appColors.black_03,
          borderRadius: BorderRadius.circular(theme.appVar.corner_01),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: primary ? 0 : 28,
            vertical: primary ? 0 : 16,
          ),
          child: Text(
            text,
            style: theme.textTheme.b_14.semiBold().white(),
          ),
        ),
      ),
    );
  }
}
