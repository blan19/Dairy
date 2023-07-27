import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DefaultLayout extends ConsumerWidget {
  final PreferredSizeWidget? appbar;
  final List<Widget>? widgets;

  const DefaultLayout({super.key, this.appbar, this.widgets});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0x00000000),
      appBar: appbar,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: Column(
          children: [
            if (widgets != null) ...widgets!,
          ],
        ),
      ),
    );
  }
}
