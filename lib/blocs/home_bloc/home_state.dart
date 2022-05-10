part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class QuizLoading extends HomeState {}

class QuizBegin extends HomeState {}

class QuizLoadingError extends HomeState {
  final String error;
  QuizLoadingError(this.error);
}
