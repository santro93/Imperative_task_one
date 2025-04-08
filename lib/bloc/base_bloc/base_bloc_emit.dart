import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imperative_task/bloc/base_bloc/screen_state.dart';
import 'exceptions/exceptions.dart';

abstract class BaseBlocEmit<E, S extends ScreenState> extends Bloc<E, S> {
  BaseBlocEmit(S initialState) : super(initialState) {
    on<E>(eventHandler);
  }

  Future<void> eventHandler(E event, Emitter<S> emit) async {
    try {
      await handleEvents(event, emit);
    } on ServiceException catch (ex) {
      emit(getErrorState()
        ..errorCode = ex.code
        ..errorMsg = ex.msg);
    } on InvalidException catch (ex) {
      emit(getErrorState()
        ..isInvalidException = true
        ..errorCode = ex.code
        ..errorMsg = ex.msg);
    } on FailedException catch (ex) {
      emit(getErrorState()
        ..errorCode = ex.code
        ..errorMsg = ex.msg);
    }
  }

  Future<void> handleEvents(E event, Emitter<S> emit);

  S getErrorState();
}
