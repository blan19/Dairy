import 'package:diary/foundation/constants.dart';
import 'package:diary/foundation/utils/date_utils.dart';
import 'package:diary/styles/app_theme.dart';
import 'package:diary/styles/app_theme_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:indexed/indexed.dart';

class DiaryItem extends ConsumerWidget {
  final String? img;
  final String process;
  final String createAt;
  final void Function()? onTap;

  const DiaryItem({
    super.key,
    required this.process,
    required this.createAt,
    this.img,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    if (process == Process.W.level) {
      return _wait(
        theme: theme,
        onTap: onTap,
      );
    }

    return _item(theme: theme, img: img!, onTap: onTap);
  }

  GestureDetector _wait({
    required AppTheme theme,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 175,
        decoration: BoxDecoration(
          color: theme.appColors.black_02,
          borderRadius: BorderRadius.circular(theme.appVar.corner_02),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "ME.RY가\n답장을 쓰고 있어요",
                    style: theme.textTheme.b_17.white().bold().lineHeight(),
                  ),
                  const Image(
                    image: AssetImage('assets/images/logo.png'),
                    width: 41,
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    createAt,
                    style: theme.textTheme.b_17.white().semiBold(),
                  ),
                  const Gap(4),
                  Text(
                    "수",
                    style: theme.textTheme.b_14.white(),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector _item({
    required AppTheme theme,
    required String img,
    void Function()? onTap,
  }) {
    final dateTime = AppDateUtils.stringToDateTime(createAt);
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: 175,
        child: Indexer(
          children: [
            Indexed(
              index: 0,
              child: Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(theme.appVar.corner_02),
                ),
                child: Image.network(
                  img,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: theme.appColors.primary,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            Indexed(
              index: 1,
              child: Positioned(
                left: 20,
                bottom: 16,
                child: Row(
                  children: [
                    Text(
                      "${dateTime.day}",
                      style: theme.textTheme.b_17.white().semiBold(),
                    ),
                    const Gap(4),
                    Text(
                      AppDateUtils.weekDay(dateTime),
                      style: theme.textTheme.b_14.white(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
