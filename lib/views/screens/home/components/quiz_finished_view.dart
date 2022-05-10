import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teamway_demo_quiz/blocs/home_bloc/home_bloc.dart';
import 'package:teamway_demo_quiz/utilities/app_config.dart';
import 'package:teamway_demo_quiz/utilities/constants.dart';
import 'package:teamway_demo_quiz/utilities/helper_functions.dart';

class QuizFinishedView extends StatelessWidget {
  final String result;
  const QuizFinishedView(this.result, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Expanded(child: SizedBox()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            getResultTitle(result),
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
            getResultDescription(result),
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
              BlocProvider.of<HomeBloc>(context).add(RetakeQuiz());
            },
            child: Text(
              'Retake the Quiz',
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
