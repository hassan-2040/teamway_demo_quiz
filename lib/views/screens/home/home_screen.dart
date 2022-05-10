import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teamway_demo_quiz/blocs/home_bloc/home_bloc.dart';
import 'package:teamway_demo_quiz/repositories/quiz_repo.dart';
import 'package:teamway_demo_quiz/utilities/app_config.dart';
import 'package:teamway_demo_quiz/views/screens/home/components/error_view.dart';
import 'package:teamway_demo_quiz/views/screens/home/components/loading_view.dart';
import 'package:teamway_demo_quiz/views/screens/home/components/question_view.dart';
import 'package:teamway_demo_quiz/views/screens/home/components/quiz_finished_view.dart';
import 'package:teamway_demo_quiz/views/screens/home/components/start_quiz_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AppConfig().setRootContext(context);
    return WillPopScope(
      onWillPop: () async {
        return await AppConfig.showConfirmationDialog(
          title: 'Quit?',
          message: 'Are you sure you want to quit?',
        );
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: AppConfig.safeAreaTop,
              color: Theme.of(context).colorScheme.primary,
            ),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state is HomeInitial) {
                    return const StartQuizView();
                  } else if (state is ShowQuestion) {
                    return QuestionView(state.index);
                  } else if (state is QuizLoadingError) {
                    return ErrorView(state.error);
                  } else if (state is QuizFinished) {
                    return QuizFinishedView(state.result);
                  } else {
                    return const LoadingView();
                  }
                },
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            final _length =
                RepositoryProvider.of<QuizRepo>(context).questions.length;
            final _index = BlocProvider.of<HomeBloc>(context).index;
            return Visibility(
              visible: state is ShowQuestion,
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _index == 0
                          ? null
                          : () {
                              BlocProvider.of<HomeBloc>(context).add(
                                ShowPreviousQuestion(),
                              );
                            },
                      child: const Text('Previous'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_index == (_length - 1)) {
                          BlocProvider.of<HomeBloc>(context).add(
                            FinishQuiz(),
                          );
                          return;
                        }

                        //if next button is pressed without selecting an option, show error
                        if (BlocProvider.of<HomeBloc>(context)
                                .answers[_index] ==
                            null) {
                          AppConfig.showFailureSnackBar(
                              snackBarText: 'You must select an option!');
                        } else {
                          BlocProvider.of<HomeBloc>(context).add(
                            ShowNextQuestion(),
                          );
                        }
                      },
                      child: Text(_index == (_length - 1) ? 'Finish' : 'Next'),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
