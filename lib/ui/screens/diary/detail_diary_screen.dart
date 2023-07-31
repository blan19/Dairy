import 'package:diary/styles/app_theme_text.dart';
import 'package:diary/ui/vm/detail_diary_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../styles/app_theme.dart';
import '../../components/appbar/mery_appbar.dart';
import '../../components/layout/default_layout.dart';
import '../../vm/add_diary_view_model.dart';

class DetailDiaryScreen extends HookConsumerWidget {
  const DetailDiaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final addDiaryViewModel = ref.watch(addDiaryViewModelProvider);
    final detailDiaryViewModel = ref.watch(detailDiaryViewModelProvider);
    useEffect(() {
      detailDiaryViewModel.getDiaryDetail("1789");
      return null;
    }, []);

    return DefaultLayout(
      appbar: MeryAppbar(
        title: "오늘의 일기",
        leading: true,
        action: GestureDetector(
          onTap: () async {
            if (addDiaryViewModel.content.isEmpty) return;
            await addDiaryViewModel.writeDiary().whenComplete(() async {
              // await homeViewModel.fetchDiaryList();
              // addDiaryViewModel.updateContent("");
            });
            if (!context.mounted) return;
            context.replace("/diary/success");
          },
          child: Icon(Icons.delete),
        ),
      ),
      widgets: [
        const Gap(8),
        Flexible(
          child: Container(
            // decoration: BoxDecoration(
            //   color: theme.appColors.black_02,
            //   borderRadius: BorderRadius.circular(theme.appVar.corner_02),
            // ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(left: 4, right: 4, bottom: 6),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.white, width: 1.0))),
                    child: Text(
                      "${addDiaryViewModel.month}월 ${addDiaryViewModel.day}일 수요일",
                      style: theme.textTheme.b_14.white().semiBold(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Gap(20),
        Flexible(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: theme.appColors.black_02,
                    borderRadius: BorderRadius.circular(theme.appVar.corner_02),
                  ),
                  child: Text(
                    detailDiaryViewModel.diary!.contents,
                    style: theme.textTheme.b_14.white().lineHeight(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
