import 'package:diary/foundation/utils/date_utils.dart';
import 'package:diary/styles/app_theme.dart';
import 'package:diary/styles/app_theme_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:indexed/indexed.dart';

class ImageItem extends ConsumerWidget {
  String img;
  String createAt;
  void Function()? onTap;
  ImageItem({super.key, required this.img, required this.createAt, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
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
              child: Container(
                width: double.infinity,
                height: 175,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(theme.appVar.corner_02),
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color.fromARGB(0, 0, 0, 0).withOpacity(0.49),
                      const Color.fromARGB(0, 0, 0, 0)
                    ],
                  ),
                ),
                child: const Row(
                  children: [],
                ),
              ),
            ),
            Indexed(
              index: 2,
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
