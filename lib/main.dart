import 'package:flutter/material.dart';
import 'package:teamway_demo_quiz/utilities/app_router.dart';
import 'package:teamway_demo_quiz/utilities/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teamway Demo Quiz',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: themeColor,
        ),
      ),
      initialRoute: AppRouter.splashScreenRoute,
      onGenerateInitialRoutes: AppRouter.generateInitialRoute,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
