import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teamway_demo_quiz/blocs/home_bloc/home_bloc.dart';
import 'package:teamway_demo_quiz/repositories/quiz_repo.dart';
import 'package:teamway_demo_quiz/utilities/app_config.dart';
import 'package:teamway_demo_quiz/utilities/constants.dart';
import 'package:teamway_demo_quiz/views/common_widgets/feedback_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    FeedbackWidgets().setRootContext(context);
    AppConfig().init(context);
    return WillPopScope(
      onWillPop: () async {
        return await FeedbackWidgets.showConfirmationDialog(
          title: 'Quit?',
          message: 'Are you sure you want to quit?',
        );
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor:
                (state is ShowQuestion) ? Colors.white70 : Colors.white,
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
                        return const _StartQuizView();
                      } else if (state is ShowQuestion) {
                        return _QuestionView(state.index);
                      } else if (state is QuizLoadingError) {
                        return _ErrorView(state.error);
                      } else {
                        return const _LoadingView();
                      }
                    },
                  ),
                ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
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
                              //TODO show result screen
                              return;
                            }
                            BlocProvider.of<HomeBloc>(context).add(
                              ShowNextQuestion(),
                            );
                          },
                          child:
                              Text(_index == (_length - 1) ? 'Finish' : 'Next'),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _StartQuizView extends StatelessWidget {
  const _StartQuizView({Key? key}) : super(key: key);

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

class _QuestionView extends StatelessWidget {
  final int index;
  const _QuestionView(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final _question =
            RepositoryProvider.of<QuizRepo>(context).questions[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Card(
            child: ListTile(
              title: Text(
                _question.question,
              ),
              subtitle: Text(
                _question.options[0]['text'],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String errorMessage;
  const _ErrorView(this.errorMessage, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(errorMessage),
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
