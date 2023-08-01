import 'package:diary/styles/app_theme.dart';
import 'package:diary/styles/app_theme_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccountInfoButton extends ConsumerWidget {
  String text;
  Color? backgroundColor;
  bool selected;
  void Function()? callback;

  AccountInfoButton(
      {super.key,
        required this.text,
        this.callback,
        this.backgroundColor,
        this.selected = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);

    return GestureDetector(
      onTap: callback,
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor ?? theme.appColors.black_02,
            borderRadius: BorderRadius.circular(theme.appVar.corner_02),
            border: selected
                ? Border.all(color: theme.appColors.primary, width: 2)
                : Border.all(color: theme.appColors.black_02, width: 2)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 16,
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: theme.textTheme.b_14.semiBold().white(),
          ),
        ),
      ),
    );
  }
}
