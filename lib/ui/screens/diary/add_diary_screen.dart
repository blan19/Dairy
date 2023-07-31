import 'package:diary/styles/app_theme.dart';
import 'package:diary/styles/app_theme_text.dart';
import 'package:diary/ui/components/appbar/mery_appbar.dart';
import 'package:diary/ui/components/dialog/mery_date_picker_dialog.dart';
import 'package:diary/ui/components/layout/default_layout.dart';
import 'package:diary/ui/vm/add_diary_view_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddDiaryScreen extends HookConsumerWidget {
  const AddDiaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final addDiaryViewModel = ref.watch(addDiaryViewModelProvider);

    return DefaultLayout(
      appbar: MeryAppbar(
        title: "일기 쓰기",
        leading: true,
        action: Text(
          "완료",
          style: theme.textTheme.b_14.primary().semiBold(),
        ),
      ),
      widgets: [
        const Gap(8),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: theme.appColors.black_02,
              borderRadius: BorderRadius.circular(theme.appVar.corner_02),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${addDiaryViewModel.month}월 ${addDiaryViewModel.day}일 수요일",
                    style: theme.textTheme.b_14.white().semiBold(),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return MeryDatePickerDialog(
                            title: "날짜를 선택해주세요.",
                            hidden: false,
                            action: (year, month, day) {
                              addDiaryViewModel.updateDate(
                                year: year,
                                month: month,
                                day: day,
                              );
                              context.pop();
                            },
                          );
                        },
                      );
                    },
                    iconSize: 24,
                    icon: Icon(
                      Icons.calendar_month_rounded,
                      color: theme.appColors.black_04,
                    ),
                  )
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
              // Text(
              //   "Hello world..!",
              //   style: theme.textTheme.t_24.white().bold(),
              // ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '오늘의 이야기를 들려주세요',
                    hintStyle: theme.textTheme.b_14.description(),
                    filled: true,
                    fillColor: theme.appColors.black_02,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                          BorderRadius.circular(theme.appVar.corner_02),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius:
                          BorderRadius.circular(theme.appVar.corner_02),
                    ),
                  ),
                  style: theme.textTheme.b_14.white().lineHeight(),
                  cursorColor: theme.appColors.white_01,
                  keyboardType: TextInputType.multiline,
                  autocorrect: false,
                  maxLines: 30,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
