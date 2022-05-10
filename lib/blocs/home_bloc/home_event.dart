part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class StartQuiz extends HomeEvent {}

class ShowPreviousQuestion extends HomeEvent {}

class ShowNextQuestion extends HomeEvent {}
