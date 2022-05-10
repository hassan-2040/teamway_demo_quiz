import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<TriggerSplashEvent>(onTriggerSplashEvent);
  }

  void onTriggerSplashEvent(TriggerSplashEvent event, emit) async {
    //waiting 2 seconds to mock an API call
    await Future.delayed(const Duration(seconds: 2));
    emit(NavigateToHome());
  }
}
