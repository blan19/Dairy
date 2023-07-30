import 'package:diary/ui/components/date_picker/mery_date_picker.dart';
import 'package:diary/ui/components/layout/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      widgets: [
        Expanded(
          child: Center(
            child: MeryDatePicker(
              hidden: false,
            ),
          ),
        ),
      ],
    );
  }
}
