import 'package:diary/styles/app_theme.dart';
import 'package:diary/styles/app_theme_text.dart';
import 'package:diary/ui/components/button/mery_button.dart';
import 'package:diary/ui/components/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SuccessDiaryScreen extends HookConsumerWidget {
  const SuccessDiaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);

    return DefaultLayout(
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(32),
                      Text(
                        "일기 작성이\n완료 되었어요!",
                        style: theme.textTheme.t_24.white().bold().lineHeight(),
                      ),
                      const Gap(24),
                      Text(
                        "(캐릭터)에게 답장이 오면\n알림을 드릴게요",
                        style: theme.textTheme.b_17.white().lineHeight(),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MeryButton(
                        text: "확인",
                        callback: () => context.replace("/"),
                      ),
                      const Gap(40),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
