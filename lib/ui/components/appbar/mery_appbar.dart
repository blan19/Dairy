import 'package:diary/styles/app_theme.dart';
import 'package:diary/styles/app_theme_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MeryAppbar extends ConsumerWidget implements PreferredSizeWidget {
  final AppBar appBar = AppBar();
  String title;

  MeryAppbar({super.key, required this.title});

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);

    return AppBar(
      elevation: 0,
      backgroundColor: theme.appColors.black_01,
      title: Text(
        title,
        style: theme.textTheme.b_14.semiBold(),
      ),
    );
  }
}
