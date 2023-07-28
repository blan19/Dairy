import 'package:diary/styles/app_var.dart';

class AppThemeVar {
  const AppThemeVar._({
    required this.corner_02,
    required this.corner_01,
    required this.spacing,
  });

  factory AppThemeVar() {
    return const AppThemeVar._(
      corner_02: AVar.corner_02,
      corner_01: AVar.corner_01,
      spacing: AVar.spacing,
    );
  }

  final double corner_02;
  final double corner_01;
  final double spacing;
}
