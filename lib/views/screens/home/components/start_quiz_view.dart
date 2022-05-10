import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teamway_demo_quiz/blocs/home_bloc/home_bloc.dart';
import 'package:teamway_demo_quiz/utilities/app_config.dart';
import 'package:teamway_demo_quiz/utilities/constants.dart';

class StartQuizView extends StatelessWidget {
  const StartQuizView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Expanded(child: SizedBox()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Are you an introvert or an extrovert?',
            textAlign: TextAlign.left,
            style: AppConfig.getTextStyle(
              context: context,
              textColor: TextColor.primary,
              textSize: TextSize.main,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Learn more about your psychology. Take the quiz to find out if you are an introvert or an extrovert.',
            textAlign: TextAlign.left,
            style: AppConfig.getTextStyle(
              context: context,
              textColor: TextColor.primaryLight,
              textSize: TextSize.large,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        const Expanded(
          flex: 3,
          child: SizedBox(),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
            ),
            onPressed: () {
              BlocProvider.of<HomeBloc>(context).add(StartQuiz());
            },
            child: Text(
              'Start Quiz',
              style: AppConfig.getTextStyle(
                context: context,
                textSize: TextSize.normal,
              ),
            ),
          ),
        ),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}
