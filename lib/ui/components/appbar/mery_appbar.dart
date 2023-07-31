import 'package:diary/styles/app_theme.dart';
import 'package:diary/styles/app_theme_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MeryAppbar extends ConsumerWidget implements PreferredSizeWidget {
  final AppBar appBar = AppBar();
  final bool leading;
  final Widget? action;

  String title;

  MeryAppbar({
    super.key,
    required this.title,
    this.leading = false,
    this.action,
  });

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);

    return AppBar(
      elevation: 0,
      backgroundColor: theme.appColors.black_01,
      leading: leading
          ? IconButton(
              onPressed: () => context.pop(),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 14,
                color: theme.appColors.black_04,
              ),
            )
          : null,
      actions: action != null
          ? [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: theme.appVar.spacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    action!,
                  ],
                ),
              ),
            ]
          : null,
      title: Text(
        title,
        style: theme.textTheme.b_14.semiBold(),
      ),
    );
  }
}
