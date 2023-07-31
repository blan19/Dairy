import 'package:diary/styles/app_theme.dart';
import 'package:diary/ui/components/button/mery_floating_action_button.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:diary/styles/app_theme_text.dart';
import 'package:diary/ui/components/appbar/mery_appbar.dart';
import 'package:diary/ui/components/button/mery_button.dart';
import 'package:diary/ui/components/layout/default_layout.dart';
import 'package:diary/ui/vm/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final homeViewModel = ref.watch(homeViewModelProvider);

    useEffect(() {
      homeViewModel.fetchDiaryList();
      return null;
    }, []);

    return DefaultLayout(
      appbar: MeryAppbar(title: "${homeViewModel.month}월"),
      floatingActionButton: MeryFloatingActionButton(
        onPressed: () => context.push("/diary/add"),
      ),
      widgets: [
        if (homeViewModel.diaryList.isEmpty) _empty(theme: theme),
        if (homeViewModel.diaryList.isNotEmpty)
          Expanded(
            child: ListView(
              children: const [],
            ),
          ),
      ],
    );
  }

  Expanded _empty({required AppTheme theme}) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "아직 이번달에 작성한\n일기가 없어요",
              style: theme.textTheme.b_17.white().lineHeight(),
              textAlign: TextAlign.center,
            ),
            const Gap(20),
            MeryButton(
              text: "일기 쓰러가기",
              primary: false,
            ),
          ],
        ),
      ),
    );
  }
}
