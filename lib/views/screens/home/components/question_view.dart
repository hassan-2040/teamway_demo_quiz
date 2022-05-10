import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teamway_demo_quiz/blocs/home_bloc/home_bloc.dart';
import 'package:teamway_demo_quiz/repositories/quiz_repo.dart';
import 'package:teamway_demo_quiz/utilities/app_config.dart';
import 'package:teamway_demo_quiz/utilities/constants.dart';

class QuestionView extends StatelessWidget {
  final int index;
  const QuestionView(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final _question =
            RepositoryProvider.of<QuizRepo>(context).questions[index];
        final _length =
            RepositoryProvider.of<QuizRepo>(context).questions.length;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(child: SizedBox()),
              Text(
                'Question ${index + 1}/$_length',
                style: AppConfig.getTextStyle(
                  context: context,
                  textColor: TextColor.disabled,
                  textSize: TextSize.normal,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _question.question,
                style: AppConfig.getTextStyle(
                  context: context,
                  textColor: TextColor.black,
                  textSize: TextSize.sub,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _question.options.length,
                itemBuilder: (context, _i) {
                  final _option = _question.options[_i];
                  return RawMaterialButton(
                    onPressed: () {
                      BlocProvider.of<HomeBloc>(context)
                          .add(SelectAnOption(_option));
                    },
                    child: Row(
                      children: [
                        Radio<dynamic>(
                          fillColor: MaterialStateColor.resolveWith(
                            (states) => Theme.of(context).colorScheme.primary,
                          ),
                          focusColor: MaterialStateColor.resolveWith(
                            (states) => Theme.of(context).primaryColorLight,
                          ),
                          value: _option,
                          groupValue:
                              BlocProvider.of<HomeBloc>(context).answers[index],
                          onChanged: (_selected) {
                            if (_selected == null) return;
                            BlocProvider.of<HomeBloc>(context)
                                .add(SelectAnOption(_option));
                          },
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            _option['text'],
                            style: AppConfig.getTextStyle(
                              context: context,
                              textColor: TextColor.black,
                              textSize: TextSize.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const Expanded(
                flex: 2,
                child: SizedBox(),
              ),
            ],
          ),
        );
      },
    );
  }
}
