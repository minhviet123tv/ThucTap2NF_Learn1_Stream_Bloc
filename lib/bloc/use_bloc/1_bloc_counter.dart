import 'package:flutter_bloc/flutter_bloc.dart';

// Event
sealed class CounterEvent {}

class CounterIncrement extends CounterEvent {}

class CounterDecrement extends CounterEvent {}

// Bloc
class CounterBloc extends Bloc<CounterEvent, int> {

  CounterBloc() : super(0) {
    on<CounterIncrement>((event, emit) {
        _increment(emit); // emit: Phát ra event
      },);
    on<CounterDecrement>((event, emit) {
        _decrement(emit);
      },);
  }

  //Tạo thêm hàm (cho những hàm phức tạp)
  _increment(Emitter emit) {
    emit(state + 1);
  }

  _decrement(Emitter emit) {
    emit(state - 1);
  }
}
