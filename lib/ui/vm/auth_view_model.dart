import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authViewModelProvider = ChangeNotifierProvider((_) => AuthViewModel());

class AuthViewModel extends ChangeNotifier {
  final bool _isAuthentication = true;

  bool get isAuthentication => _isAuthentication;

  String? redirect(BuildContext _, GoRouterState __) {
    if (isAuthentication) return "/";
    return null;
  }
}
