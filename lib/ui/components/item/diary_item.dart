import 'package:diary/foundation/constants.dart';
import 'package:diary/styles/app_theme.dart';
import 'package:diary/styles/app_theme_text.dart';
import 'package:diary/ui/components/item/image_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

    return ImageItem(img: img!, createAt: createAt, onTap: onTap);
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
}
