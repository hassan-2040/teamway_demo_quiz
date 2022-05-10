part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class QuizLoading extends HomeState {}

class ShowQuestion extends HomeState {
  final int index;
  ShowQuestion(this.index);
}

class QuizFinished extends HomeState {
  final String result;
  QuizFinished(this.result);
}

class QuizLoadingError extends HomeState {
  final String error;
  QuizLoadingError(this.error);
}
