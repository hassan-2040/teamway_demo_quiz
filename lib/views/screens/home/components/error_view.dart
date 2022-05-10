import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teamway_demo_quiz/blocs/home_bloc/home_bloc.dart';

class ErrorView extends StatelessWidget {
  final String errorMessage;
  const ErrorView(this.errorMessage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(errorMessage),
        ),
        ElevatedButton(
          onPressed: () {
            BlocProvider.of<HomeBloc>(context).add(StartQuiz());
          },
          child: const Text('Retry'),
        ),
      ],
    );
  }
}
