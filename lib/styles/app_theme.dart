import 'package:diary/styles/app_theme_colors.dart';
import 'package:diary/styles/app_theme_text.dart';
import 'package:diary/styles/app_theme_var.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final appThemeProvider = Provider<AppTheme>((_) => AppTheme());

class AppTheme {
  AppTheme._({
    required this.data,
    required this.textTheme,
    required this.appColors,
    required this.appVar,
  });

  factory AppTheme() {
    final appColors = AppThemeColors();
    final themeData = ThemeData(
      scaffoldBackgroundColor: appColors.black_01,
    );
    final appText = AppThemeText();
    final appVar = AppThemeVar();

    return AppTheme._(
      data: themeData,
      textTheme: appText,
      appColors: appColors,
      appVar: appVar,
    );
  }

  final ThemeData data;
  final AppThemeText textTheme;
  final AppThemeColors appColors;
  final AppThemeVar appVar;
}
