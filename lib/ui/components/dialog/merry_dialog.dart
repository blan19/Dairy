import 'package:diary/styles/app_theme.dart';
import 'package:diary/styles/app_theme_text.dart';
import 'package:diary/ui/components/button/mery_button.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MeryDialog extends HookConsumerWidget {
  String title;
  String actionText;
  String? description;
  void Function()? action;

  MeryDialog(
      {super.key,
      required this.title,
      required this.actionText,
      this.description,
      this.action});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(theme.appVar.corner_02),
      ),
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.only(
        top: 48,
        bottom: 8,
      ),
      actionsPadding: const EdgeInsets.only(bottom: 48, top: 36),
      backgroundColor: theme.appColors.black_01,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: theme.textTheme.b_17.semiBold().white().lineHeight(),
          )
        ],
      ),
      content: description != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  description!,
                  style: theme.textTheme.b_14.white().lineHeight(),
                  textAlign: TextAlign.center,
                )
              ],
            )
          : null,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MeryButton(
              text: actionText,
              primary: false,
              callback: action,
            ),
          ],
        )
      ],
    );
  }
}
