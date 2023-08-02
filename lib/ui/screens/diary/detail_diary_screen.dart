import 'package:diary/foundation/utils/date_utils.dart';
import 'package:diary/styles/app_theme.dart';
import 'package:diary/styles/app_theme_text.dart';
import 'package:diary/ui/components/appbar/mery_appbar.dart';
import 'package:diary/ui/components/dialog/merry_dialog.dart';
import 'package:diary/ui/components/layout/default_layout.dart';
import 'package:diary/ui/vm/detail_diary_view_model.dart';
import 'package:diary/ui/vm/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailDiaryScreen extends HookConsumerWidget {
  final String id;

  const DetailDiaryScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final detailDiaryViewModel = ref.watch(detailDiaryViewModelProvider);
    final homeViewModel = ref.watch(homeViewModelProvider);

    useEffect(() {
      detailDiaryViewModel.fetchDiary(id);
      return null;
    }, [id]);

    return DefaultLayout(
      appbar: MeryAppbar(
        leading: true,
        title: Text(
          "오늘의 일기",
          style: theme.textTheme.b_14.semiBold().white(),
        ),
        action: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (_) {
                return MeryDialog(
                  title: "일기를 삭제하시겠어요?",
                  description: "삭제된 일기는\n복구할 수 없어요",
                  actionText: "삭제",
                  action: () {
                    if (detailDiaryViewModel.diary == null) return;
                    detailDiaryViewModel
                        .deleteDiary(detailDiaryViewModel.diary!.darId)
                        .whenComplete(
                      () {
                        homeViewModel.fetchDiaryList().whenComplete(() {
                          context.pop();
                          context.pop();
                        });
                      },
                    );
                  },
                );
              },
            );
          },
          child: Icon(
            Icons.delete_rounded,
            color: theme.appColors.black_04,
            size: 24,
          ),
        ),
      ),
      child: detailDiaryViewModel.diary != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: theme.appColors.white_01,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      "${detailDiaryViewModel.dateTime!.month}월 ${detailDiaryViewModel.dateTime!.day}일 ${AppDateUtils.weekDay(detailDiaryViewModel.dateTime!)}요일",
                      style: theme.textTheme.b_14.semiBold().white(),
                    ),
                  ),
                ),
                const Gap(16),
                Flexible(
                  flex: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.appColors.black_02,
                      borderRadius: BorderRadius.circular(
                        theme.appVar.corner_02,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                text: detailDiaryViewModel.diary!.contents,
                                style:
                                    theme.textTheme.b_14.white().lineHeight(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: theme.appColors.black_03,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  theme.appVar.corner_02,
                                ),
                                topRight: Radius.circular(
                                  theme.appVar.corner_02,
                                ),
                                bottomLeft: Radius.circular(
                                  theme.appVar.corner_02,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    detailDiaryViewModel.diary!.imgUrl !=
                                                null &&
                                            detailDiaryViewModel
                                                    .diary!.answer !=
                                                null
                                        ? "ME.RY의 답장을 확인해봐!"
                                        : "ME.RY가 답장을 준비하고있어",
                                    style: theme.textTheme.b_14.white(),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Gap(8),
                          GestureDetector(
                            onTap: () {
                              if (detailDiaryViewModel.diary!.imgUrl == null ||
                                  detailDiaryViewModel.diary!.answer == null) {
                                return;
                              }
                              context.push("/diary/answer");
                            },
                            child: const Image(
                              image: AssetImage("assets/images/logo.png"),
                              width: 71.3,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(25)
              ],
            )
          : Center(
              child: CircularProgressIndicator(
                color: theme.appColors.primary,
              ),
            ),
    );
  }
}
