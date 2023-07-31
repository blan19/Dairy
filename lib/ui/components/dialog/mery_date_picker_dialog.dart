import 'package:diary/styles/app_theme.dart';
import 'package:diary/styles/app_theme_text.dart';
import 'package:diary/ui/components/button/mery_button.dart';
import 'package:diary/ui/components/date_picker/mery_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MeryDatePickerDialog extends HookConsumerWidget {
  String title;
  bool hidden;
  void Function(int year, int month, int day)? action;

  MeryDatePickerDialog({
    super.key,
    required this.title,
    this.hidden = false,
    this.action,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final now = DateTime.now();
    final dYear = useState(now.year);
    final dMonth = useState(now.month);
    final dDay = useState(now.day);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(theme.appVar.corner_02),
      ),
      contentPadding: const EdgeInsets.only(
        top: 0,
      ),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      backgroundColor: theme.appColors.black_01,
      titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      title: Text(
        title,
        style: theme.textTheme.b_17.white().semiBold(),
      ),
      content: Row(
        children: [
          Flexible(
            child: MeryDatePicker(
              hidden: hidden,
              initialData: [dYear.value, dMonth.value, dDay.value],
              onChanged: (year, month, day) {
                dYear.value = year;
                dMonth.value = month;
                dDay.value = day;
              },
            ),
          ),
        ],
      ),
      actions: [
        MeryButton(
          text: "선택하기",
          primary: true,
          callback: () {
            if (action != null) action!(dYear.value, dMonth.value, dDay.value);
          },
        )
      ],
    );
  }
}
