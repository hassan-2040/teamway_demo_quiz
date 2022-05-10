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
      {}; //key: question index in quiz repo list, value: one of the options Map from json. 

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

//The keys of the answers map are the question indexes in the quiz repo list.
//They can be used to show answers back to the user if needed, which is why
//I used a Map for answers. 
  void onFinishQuiz(FinishQuiz event, emit) {
    emit(QuizLoading());
    int _introvertCount = 0;
    int _extrovertCount = 0;
    String _result = '';
    for (var element in answers.values) {
      if (element['result'] == 'introvert') {
        _introvertCount++;
      } else {
        _extrovertCount++;
      }
    }
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
