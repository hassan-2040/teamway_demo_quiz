import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:teamway_demo_quiz/repositories/quiz_repo.dart';
import 'package:teamway_demo_quiz/utilities/custom_error_responses.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final QuizRepo _quizRepo;

  int index = 0;

  HomeBloc(this._quizRepo) : super(HomeInitial()) {
    on<StartQuiz>(onStartQuiz);
    on<ShowPreviousQuestion>(onShowPreviousQuestion);
    on<ShowNextQuestion>(onShowNextQuestion);
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

  void onShowPreviousQuestion(ShowPreviousQuestion event, emit) {
    index = index - 1;
    emit(ShowQuestion(index));
  }

  void onShowNextQuestion(ShowNextQuestion event, emit) {
    index = index + 1;
    emit(ShowQuestion(index));
  }

}
