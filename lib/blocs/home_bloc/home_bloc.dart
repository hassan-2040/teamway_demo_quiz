import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:teamway_demo_quiz/repositories/quiz_repo.dart';
import 'package:teamway_demo_quiz/utilities/custom_error_responses.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final QuizRepo _quizRepo;

  int index = 0;

  Map<int, dynamic> answers =
      {}; //key: question index in quiz repo list, value: answer index in terms of A,B,C,D

  HomeBloc(this._quizRepo) : super(HomeInitial()) {
    on<StartQuiz>(onStartQuiz);
    on<SelectAnOption>(onSelectAnOption);
    on<ShowPreviousQuestion>(onShowPreviousQuestion);
    on<ShowNextQuestion>(onShowNextQuestion);
    on<FinishQuiz>(onFinishQuiz);
    on<RetakeQuiz>(onRetakeQuiz);
  }

  void onStartQuiz(StartQuiz event, emit) async {
    emit(QuizLoading());
    try {
      await _quizRepo.fetchQuestions();
      emit(ShowQuestion(index));
    } on Exception catch (_error) {
      emit(QuizLoadingError(customErrorResponses(_error)));
    }
  }

  void onSelectAnOption(SelectAnOption event, emit) {
    answers[index] = event.option;
    emit(ShowQuestion(index));
  }

  void onShowPreviousQuestion(ShowPreviousQuestion event, emit) {
    index = index - 1;
    emit(ShowQuestion(index));
  }

  void onShowNextQuestion(ShowNextQuestion event, emit) {
    index = index + 1;
    emit(ShowQuestion(index));
  }

  void onFinishQuiz(FinishQuiz event, emit) {
    emit(QuizLoading());
    int _introvertCount = 0;
    int _extrovertCount = 0;
    String _result = '';
    answers.forEach((key, value) {
      final _question = _quizRepo.questions[key];
      final _result = _question.options
          .firstWhere((element) => element['optionLetter'] == value)['result'];
      if (_result == 'introvert') {
        _introvertCount++;
      } else {
        _extrovertCount++;
      }
    });
    if (_introvertCount > _extrovertCount) {
      _result = 'introvert';
    } else {
      _result = 'extrovert';
    }
    emit(QuizFinished(_result));
  }

  void onRetakeQuiz(RetakeQuiz event, emit) {
    index = 0;
    answers.clear();
    emit(ShowQuestion(index));
  }
}
