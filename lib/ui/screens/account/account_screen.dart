import 'package:diary/styles/app_theme.dart';
import 'package:diary/styles/app_theme_text.dart';
import 'package:diary/ui/components/button/account_info_button.dart';
import 'package:diary/ui/components/button/mery_button.dart';
import 'package:diary/ui/components/layout/default_layout.dart';
import 'package:diary/ui/vm/account_view_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccountScreen extends HookConsumerWidget {
  const AccountScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final accountViewModel = ref.watch(accountViewModelProvider);

    return DefaultLayout(
      widgets: [
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
                      "당신에 대해 알려주세요",
                      style: theme.textTheme.t_24.white().bold().lineHeight(),
                    ),
                    const Gap(24),
                    Text(
                      "Me.ry가 당신에 대해 더 잘 알 수 있어요.",
                      style: theme.textTheme.b_17.white().lineHeight(),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(32),
                    Text(
                      "성별",
                      style: theme.textTheme.b_14
                          .primary()
                          .semiBold()
                          .lineHeight(),
                    ),
                    const Gap(24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: AccountInfoButton(
                            text: "남자",
                            callback: () => accountViewModel.updateGender('M'),
                            selected: accountViewModel.gender == 'M',
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          flex: 1,
                          child: AccountInfoButton(
                            text: "여자",
                            callback: () => accountViewModel.updateGender('F'),
                            selected: accountViewModel.gender == 'F',
                          ),
                        ),
                      ],
                    ),
                    const Gap(32),
                    Text(
                      "나이",
                      style: theme.textTheme.b_14
                          .primary()
                          .semiBold()
                          .lineHeight(),
                    ),
                    const Gap(24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: AccountInfoButton(
                            text: "10대",
                            callback: () => accountViewModel.updateAge(10),
                            selected: accountViewModel.age == 10,
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          flex: 1,
                          child: AccountInfoButton(
                            text: "20대",
                            callback: () => accountViewModel.updateAge(20),
                            selected: accountViewModel.age == 20,
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: AccountInfoButton(
                            text: "30대",
                            callback: () => accountViewModel.updateAge(30),
                            selected: accountViewModel.age == 30,
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          flex: 1,
                          child: AccountInfoButton(
                            text: "40대",
                            callback: () => accountViewModel.updateAge(40),
                            selected: accountViewModel.age == 40,
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: AccountInfoButton(
                            text: "50대",
                            callback: () => accountViewModel.updateAge(50),
                            selected: accountViewModel.age == 50,
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          flex: 1,
                          child: AccountInfoButton(
                            text: "기타",
                            callback: () => accountViewModel.updateAge(60),
                            selected: accountViewModel.age == 60,
                          ),
                        ),
                      ],
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
                      callback: () async {
                        if (accountViewModel.gender == null ||
                            accountViewModel.age == null) return;
                        await accountViewModel.signUp();
                        if (!context.mounted) return;
                        context.replace("/");
                      },
                    ),
                    const Gap(40),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
