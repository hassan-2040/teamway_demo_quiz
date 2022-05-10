import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teamway_demo_quiz/blocs/splash_bloc/splash_bloc.dart';
import 'package:teamway_demo_quiz/utilities/app_config.dart';
import 'package:teamway_demo_quiz/utilities/app_router.dart';
import 'package:teamway_demo_quiz/utilities/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideRightValue;
  late Animation<Offset> _slideLeftValue;

  @override
  void initState() {
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _slideRightValue =
        Tween(begin: const Offset(3.0, 0.0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: Curves.elasticOut,
      ),
    );

    _slideLeftValue =
        Tween(begin: const Offset(-3.0, 0.0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: Curves.elasticOut,
      ),
    );

    _runAnimation();

    super.initState();
  }

  _runAnimation() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppConfig().setRootContext(context);
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is NavigateToHome) {
          Navigator.pushReplacementNamed(
            context,
            AppRouter.homeScreenRoute,
          );
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SlideTransition(
                position: _slideLeftValue,
                child: Text(
                  'Introvert',
                  style: AppConfig.getTextStyle(
                    context: context,
                    textSize: TextSize.main,
                    fontWeight: FontWeight.bold,
                    textColor: TextColor.white,
                  ),
                ),
              ),
              Text(
                'OR',
                style: AppConfig.getTextStyle(
                  context: context,
                  textSize: TextSize.large,
                  fontWeight: FontWeight.bold,
                  textColor: TextColor.white,
                ),
              ),
              SlideTransition(
                position: _slideRightValue,
                child: Text(
                  'Extrovert?',
                  style: AppConfig.getTextStyle(
                    context: context,
                    textSize: TextSize.main,
                    fontWeight: FontWeight.bold,
                    textColor: TextColor.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
