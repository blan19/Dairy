import 'package:diary/styles/app_color.dart';
import 'package:diary/styles/app_font_size.dart';
import 'package:flutter/material.dart';

class AppThemeText {
  const AppThemeText._({
    required this.t_24,
    required this.b_17,
    required this.b_14,
  });

  factory AppThemeText() {
    return const AppThemeText._(
      t_24: TextStyle(fontSize: AFontSize.pt_24),
      b_17: TextStyle(fontSize: AFontSize.pt_17),
      b_14: TextStyle(fontSize: AFontSize.pt_14),
    );
  }

  final TextStyle t_24;
  final TextStyle b_17;
  final TextStyle b_14;
}

extension TextStyleExt on TextStyle {
  TextStyle bold() => copyWith(fontWeight: FontWeight.w700);
  TextStyle semiBold() => copyWith(fontWeight: FontWeight.w600);
  TextStyle lineHeight() => copyWith(height: 1.5);
  TextStyle white() => copyWith(color: AColor.white_01);
  TextStyle title() => copyWith(color: AColor.black_01);
  TextStyle description() => copyWith(color: AColor.black_04);
  TextStyle primary() => copyWith(color: AColor.primary);
  TextStyle warning() => copyWith(color: AColor.warning);
  TextStyle transparent() => copyWith(color: AColor.black_04.withOpacity(0.3));
}
