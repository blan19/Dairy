import 'package:diary/styles/app_theme.dart';
import 'package:diary/styles/app_theme_text.dart';
import 'package:diary/ui/components/appbar/mery_appbar.dart';
import 'package:diary/ui/components/layout/default_layout.dart';
import 'package:diary/ui/vm/detail_diary_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
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
          onTap: () {},
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
                      "7월 25일 수요일",
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
                                    "ME.RY의 답장을 확인해봐!",
                                    style: theme.textTheme.b_14.white(),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Gap(8),
                          const Image(
                            image: AssetImage("assets/images/logo.png"),
                            width: 71.3,
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
