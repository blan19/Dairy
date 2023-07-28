import 'package:diary/styles/app_color.dart';
import 'package:flutter/material.dart';

class AppThemeColors {
  const AppThemeColors._({
    required this.primary,
    required this.primarySecondary,
    required this.warning,
    required this.warningSecondary,
    required this.white_03,
    required this.white_02,
    required this.white_01,
    required this.black_04,
    required this.black_03,
    required this.black_02,
    required this.black_01,
  });

  factory AppThemeColors() {
    return const AppThemeColors._(
      primary: AColor.primary,
      primarySecondary: AColor.primarySecondary,
      warning: AColor.warning,
      warningSecondary: AColor.warningSecondary,
      white_03: AColor.white_03,
      white_02: AColor.white_02,
      white_01: AColor.white_01,
      black_04: AColor.black_04,
      black_03: AColor.black_03,
      black_02: AColor.black_02,
      black_01: AColor.black_01,
    );
  }

  final Color primary;
  final Color primarySecondary;
  final Color warning;
  final Color warningSecondary;
  final Color white_03;
  final Color white_02;
  final Color white_01;
  final Color black_04;
  final Color black_03;
  final Color black_02;
  final Color black_01;
}
