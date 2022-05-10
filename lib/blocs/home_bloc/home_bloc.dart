import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:teamway_demo_quiz/repositories/quiz_repo.dart';
import 'package:teamway_demo_quiz/utilities/custom_error_responses.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final QuizRepo _quizRepo;

  HomeBloc(this._quizRepo) : super(HomeInitial()) {
    on<StartQuiz>(onStartQuiz);
  }

  void onStartQuiz(StartQuiz event, emit) async {
    emit(QuizLoading());
    try {
      await _quizRepo.fetchQuestions();
      emit(QuizBegin());
    } on Exception catch (_error) {
      emit(QuizLoadingError(customErrorResponses(_error)));
    }
  }
}
