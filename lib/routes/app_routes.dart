import 'package:flutter/material.dart';
import '../features/auth/presentation/pages/sign_in_page/sign_in_page.dart';
import '../features/auth/presentation/pages/sign_up_page/sign_up_page.dart';
import '../features/main/presentation/pages/main_page/main_page.dart';
import '../features/splash_page/splash_page.dart';
import 'name_routes.dart';

class AppRoutes {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case RouteName.signIn:
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case RouteName.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case RouteName.mainPage:
        return MaterialPageRoute(builder: (_) => const MainPage());
      default:
        return MaterialPageRoute(builder: (_) => const Scaffold());
    }
  }
}