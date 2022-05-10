import 'package:flutter/material.dart';
import 'package:teamway_demo_quiz/utilities/app_config.dart';
import 'package:teamway_demo_quiz/utilities/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppConfig().init(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: AppConfig.safeAreaTop,
            color: Theme.of(context).colorScheme.primary,
          ),
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
              onPressed: () {},
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
      ),
    );
  }
}
