import 'package:diary/styles/app_theme.dart';
import 'package:diary/styles/app_theme_text.dart';
import 'package:diary/ui/components/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);

    return DefaultLayout(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "나를 위한 다이어리",
              style: theme.textTheme.b_14.white().lineHeight(),
            ),
            const Gap(4),
            Text(
              "ME.RY",
              style: theme.textTheme.t_24.white().lineHeight(),
            ),
            const Gap(64),
            const Image(
              image: AssetImage("assets/images/splash_logo.png"),
              width: 103.5,
            )
          ],
        ),
      ),
    );
  }
}
