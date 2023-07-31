import 'package:diary/foundation/utils/date_utils.dart';
import 'package:diary/styles/app_theme.dart';
import 'package:diary/styles/app_theme_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MeryDatePicker extends HookConsumerWidget {
  bool hidden;
  List<int> initialData;
  void Function(int year, int month, int day)? onChanged;

  MeryDatePicker({
    super.key,
    required this.hidden,
    required this.initialData,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final year = useState(initialData[0]);
    final month = useState(initialData[1]);
    final day = useState(initialData[2]);

    final years =
        useMemoized(() => AppDateUtils.createDiaryYear().reversed.toList());
    final months = useMemoized(
      () => AppDateUtils.createDiaryMonth(year.value).reversed.toList(),
      [year.value],
    );
    final days = useMemoized(
      () => AppDateUtils.createDiaryDay(year.value, month.value)
          .reversed
          .toList(),
      [year.value, month.value],
    );

    FixedExtentScrollController yearController =
        FixedExtentScrollController(initialItem: years.indexOf(initialData[0]));
    FixedExtentScrollController monthController = FixedExtentScrollController(
        initialItem: months.indexOf(initialData[1]));
    FixedExtentScrollController dayController =
        FixedExtentScrollController(initialItem: days.indexOf(initialData[2]));

    void jumpToMonthAndDay() {
      final monthIndex = months.indexOf(month.value);
      final dayIndex = days.indexOf(day.value);

      if (monthIndex != -1) {
        monthController.jumpToItem(monthIndex);
      } else {
        monthController.jumpToItem(months.length - 1);
      }
      if (dayIndex != -1) {
        dayController.jumpToItem(dayIndex);
      } else {
        dayController.jumpToItem(days.length - 1);
      }
    }

    void jumpToDay() {
      final dayIndex = days.indexOf(day.value);

      if (dayIndex != -1) {
        dayController.jumpToItem(dayIndex);
      } else {
        dayController.jumpToItem(days.length - 1);
      }
    }

    useEffect(() {
      if (onChanged != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          onChanged!(year.value, month.value, day.value);
        });
      }
      return null;
    }, [year.value, month.value, day.value]);

    return SizedBox(
      width: double.infinity,
      height: 158,
      child: Row(
        children: [
          _picker(
            controller: yearController,
            data: years,
            state: year,
            theme: theme,
            callback: jumpToMonthAndDay,
            suffix: "년",
          ),
          _picker(
            controller: monthController,
            data: months,
            state: month,
            theme: theme,
            callback: jumpToDay,
            suffix: "월",
          ),
          if (!hidden)
            _picker(
              controller: dayController,
              data: days,
              state: day,
              theme: theme,
              suffix: "일",
            ),
        ],
      ),
    );
  }

  Flexible _picker({
    required FixedExtentScrollController controller,
    required List<int> data,
    required String suffix,
    required AppTheme theme,
    required ValueNotifier<int> state,
    void Function()? callback,
  }) {
    return Flexible(
      child: ListWheelScrollView(
        itemExtent: 42,
        perspective: 0.004,
        squeeze: 1.0,
        physics: const FixedExtentScrollPhysics(),
        controller: controller,
        onSelectedItemChanged: (value) {
          HapticFeedback.lightImpact();
          state.value = data[value];
        },
        children: List.generate(
          data.length,
          (index) => Container(
            width: 81,
            height: 42,
            decoration: BoxDecoration(
              color:
                  state.value == data[index] ? theme.appColors.black_03 : null,
              borderRadius: BorderRadius.circular(theme.appVar.corner_02),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${data[index]}$suffix",
                  style: state.value == data[index]
                      ? theme.textTheme.b_17.white().semiBold()
                      : (state.value - data[index]).abs() >= 2
                          ? theme.textTheme.b_14.transparent()
                          : theme.textTheme.b_14.description(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
