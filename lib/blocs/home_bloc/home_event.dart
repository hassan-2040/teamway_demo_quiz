part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class StartQuiz extends HomeEvent {}

class ShowPreviousQuestion extends HomeEvent {}

class ShowNextQuestion extends HomeEvent {}

class SelectAnOption extends HomeEvent {
  final String option;
  SelectAnOption(this.option);
}

class FinishQuiz extends HomeEvent {}

class RetakeQuiz extends HomeEvent {}
