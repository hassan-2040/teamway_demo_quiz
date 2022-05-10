import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teamway_demo_quiz/blocs/home_bloc/home_bloc.dart';
import 'package:teamway_demo_quiz/blocs/splash_bloc/splash_bloc.dart';
import 'package:teamway_demo_quiz/repositories/quiz_repo.dart';
import 'package:teamway_demo_quiz/utilities/app_router.dart';
import 'package:teamway_demo_quiz/utilities/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<QuizRepo>(
          create: (context) => QuizRepo(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<SplashBloc>(
            create: (context) => SplashBloc()..add(TriggerSplashEvent()),
          ),
          BlocProvider<HomeBloc>(
            create: (context) =>
                HomeBloc(RepositoryProvider.of<QuizRepo>(context)),
          ),
        ],
        child: MaterialApp(
          title: 'Teamway Demo Quiz',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: themeColor,
              primaryColorDark: primaryColorDark,
              accentColor: accentColor,
            ),
          ),
          initialRoute: AppRouter.splashScreenRoute,
          onGenerateInitialRoutes: AppRouter.generateInitialRoute,
          onGenerateRoute: AppRouter.generateRoute,
        ),
      ),
    );
  }
}
