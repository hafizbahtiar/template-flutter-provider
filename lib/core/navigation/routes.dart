import 'package:flutter/material.dart';
import 'package:template_flutter_provider/core/navigation/routes_name.dart';
import 'package:template_flutter_provider/features/auth/screens/sign_in_screen.dart';
import 'package:template_flutter_provider/features/auth/screens/sign_up_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.signIn:
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
          settings: RouteSettings(name: RoutesName.signIn),
        );
      case RoutesName.signUp:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
          settings: RouteSettings(name: RoutesName.signUp),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) => const Scaffold(body: Center(child: Text('Error: Route not found'))));
  }
}
