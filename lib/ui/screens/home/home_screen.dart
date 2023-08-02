import 'package:diary/foundation/utils/async_snapshot.dart';
import 'package:diary/styles/app_theme.dart';
import 'package:diary/ui/components/button/mery_floating_action_button.dart';
import 'package:diary/ui/components/dialog/mery_date_picker_dialog.dart';
import 'package:diary/ui/components/item/diary_item.dart';
import 'package:diary/ui/vm/loading_view_model.dart';
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
    final homeViewModel = ref.read(homeViewModelProvider);
    final diaryList =
        ref.watch(homeViewModelProvider.select((value) => value.diaryList));
    final year = ref.watch(homeViewModelProvider.select((value) => value.year));
    final month =
        ref.watch(homeViewModelProvider.select((value) => value.month));

    final snapshot = useFuture(
      useMemoized(() {
        return ref
            .read(loadingStateProvider)
            .whileLoading(homeViewModel.fetchDiaryList);
      }, [year, month]),
    );

    return DefaultLayout(
      appbar: MeryAppbar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$month월",
              style: theme.textTheme.b_14.semiBold(),
            ),
            const Gap(4),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return MeryDatePickerDialog(
                      title: "월을 선택해주세요",
                      hidden: true,
                      action: (year, month, _) {
                        homeViewModel.updateYear(year);
                        homeViewModel.updateMonth(month);
                        context.pop();
                      },
                    );
                  },
                );
              },
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 20,
                color: theme.appColors.black_04,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: MeryFloatingActionButton(
        onPressed: () => context.push("/diary/add"),
      ),
      child: snapshot.isWaiting
          ? _loading(theme: theme)
          : diaryList.isEmpty
              ? _empty(theme: theme, context: context)
              : RefreshIndicator(
                  onRefresh: () async {
                    await homeViewModel.fetchDiaryList();
                  },
                  child: ListView.separated(
                    itemCount: diaryList.length,
                    itemBuilder: (_, index) {
                      final diary = diaryList[index];
                      return DiaryItem(
                        process: diary.process,
                        createAt: diary.createAt,
                        img: diary.imgUrl,
                        onTap: () => context.push("/diary/${diary.darId}"),
                      );
                    },
                    separatorBuilder: (_, index) {
                      return const Gap(20);
                    },
                  ),
                ),
    );
  }

  Center _empty({
    required AppTheme theme,
    required BuildContext context,
  }) {
    return Center(
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
            callback: () => context.push("/diary/add"),
          ),
        ],
      ),
    );
  }

  Center _loading({required AppTheme theme}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage("assets/images/loading.png"),
            width: 89,
          ),
          const Gap(20),
          Text(
            "일기를\n가져오고 있어요",
            style: theme.textTheme.b_17.white().lineHeight(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
