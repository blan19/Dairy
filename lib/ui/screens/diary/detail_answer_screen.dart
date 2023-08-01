import 'package:diary/styles/app_theme.dart';
import 'package:diary/styles/app_theme_text.dart';
import 'package:diary/ui/components/appbar/mery_appbar.dart';
import 'package:diary/ui/components/item/image_item.dart';
import 'package:diary/ui/components/layout/default_layout.dart';
import 'package:diary/ui/vm/detail_diary_view_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DetailAnswerScreen extends HookConsumerWidget {
  const DetailAnswerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final detailDiaryViewModel = ref.watch(detailDiaryViewModelProvider);

    return DefaultLayout(
      appbar: MeryAppbar(title: const Text("")),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "ME.RY의 쪽지",
                  style: theme.textTheme.b_17.white(),
                ),
                const Gap(4),
                Text(
                  "ME.RY가 당신의 하루와 함께 메세지를 보냈어요.",
                  style: theme.textTheme.b_14.white(),
                ),
                const Gap(24),
                if (detailDiaryViewModel.diary != null)
                  ImageItem(
                    img: detailDiaryViewModel.diary!.imgUrl,
                    createAt: detailDiaryViewModel.diary!.createAt,
                  ),
                if (detailDiaryViewModel.diary != null) const Gap(16),
                if (detailDiaryViewModel.diary != null)
                  Container(
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
                                text: detailDiaryViewModel.diary!.answer,
                                style:
                                    theme.textTheme.b_14.white().lineHeight(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Flexible(
            flex: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: const Image(
                    image: AssetImage("assets/images/logo.png"),
                    width: 71.3,
                  ),
                ),
              ],
            ),
          ),
          const Gap(25),
        ],
      ),
    );
  }
}
