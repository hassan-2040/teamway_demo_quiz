import 'package:flutter/material.dart';
import 'package:teamway_demo_quiz/views/screens/home/home_screen.dart';
import 'package:teamway_demo_quiz/views/screens/splash_screen.dart';

class AppRouter {
  //app route names
  static const String splashScreenRoute = '/splashScreen';
  static const String homeScreenRoute = '/homeScreen';

  ///Used this function to make sure the home attribute of MaterialApp is not rendered
  ///in addition to the required screens. If this is not overridden, an extra screen pops up
  ///in the beginning of the navigation stack, as the base route '/'.
  ///See https://api.flutter.dev/flutter/widgets/WidgetsApp/initialRoute.html
  static List<Route<dynamic>> generateInitialRoute(String _string) {
    //use a switch statement to match strings to screens based on use-case
    return [
      MaterialPageRoute(
        builder: (_) => const SplashScreen(),
      ),
    ];
  }

  static Route<dynamic> generateRoute(RouteSettings _settings) {
    switch (_settings.name) {
      case splashScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case homeScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${_settings.name}'),
            ),
          ),
        );
    }
  }
}
