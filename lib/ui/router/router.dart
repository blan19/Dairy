import 'package:diary/ui/screens/account/account_screen.dart';
import 'package:diary/ui/screens/diary/add_diary_screen.dart';
import 'package:diary/ui/screens/diary/detail_diary_screen.dart';
import 'package:diary/ui/screens/home/home_screen.dart';
import 'package:diary/ui/screens/splash/spash_screen.dart';
import 'package:diary/ui/vm/auth_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final routerProvider = Provider(
  (ref) {
    final authViewModel = ref.watch(authViewModelProvider);

    return GoRouter(
      redirect: authViewModel.redirect,
      refreshListenable: authViewModel,
      initialLocation: "/splash",
      routes: [
        GoRoute(
          path: "/",
          name: "home_screen",
          builder: (_, __) => const HomeScreen(),
        ),
        GoRoute(
          path: "/diary/add",
          name: "diary_add_screen",
          builder: (_, __) => const AddDiaryScreen(),
        ),
        GoRoute(
          path: "/diary/:id",
          name: "diary_detail_screen",
          builder: (_, __) => const DetailDiaryScreen(),
        ),
        GoRoute(
          path: "/account",
          name: "account_screen",
          builder: (_, __) => const AccountScreen(),
        ),
        GoRoute(
          path: "/splash",
          name: "splash_screen",
          builder: (_, __) => const SplashScreen(),
        ),
      ],
    );
  },
);
