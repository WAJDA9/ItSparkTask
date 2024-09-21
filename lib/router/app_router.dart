import 'package:flutter/material.dart';
import 'package:itsparktask/ui/home_screen.dart';
import 'package:itsparktask/ui/login_screen.dart';
import 'package:itsparktask/ui/splash_screen.dart';
class AppRouter {
  
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
    }

    return null;
  }
}
