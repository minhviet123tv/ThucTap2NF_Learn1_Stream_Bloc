import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class CounterEvent {}

final class CounterIncrementPressed extends CounterEvent {
  late int number;

  CounterIncrementPressed(this.number);
}

final class CounterDecrementPressed extends CounterEvent {
  late int number;

  CounterDecrementPressed(this.number);
}

//I. Tạo Bloc, cấu trúc extends Bloc<CustomEvent, int>: Các event của CustomEvent được tạo như một hoặc nhiều câu lệnh
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(10) {
    on<CounterIncrementPressed>((event, emit) {
      emit(state + event.number);
    });

    on<CounterDecrementPressed>((event, emit) {
      emit(state - event.number);
    });
  }

  @override
  void onEvent(CounterEvent event) {
    super.onEvent(event);
    print('$event - by onEvent in Bloc');
  }

  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    super.onTransition(transition);
    print('$transition - by onTransition in Bloc');
  }

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print('$change - by onChange in Bloc');
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print('$error, $stackTrace - by onChange in Bloc');
  }
}

//II.2 Sử dụng bloc và dùng listen để lắng nghe trạng thái | Hoặc truy cập dữ liệu của bloc bằng: bloc.stream.listen((data){});
Future<void> main() async {
  // Tạo bloc
  final bloc = CounterBloc();

  // Listen 1: Thực hiện print mỗi khi có thay đổi
  final listen1 = bloc.stream.listen(print);

  bloc.add(CounterIncrementPressed(10));
  bloc.add(CounterDecrementPressed(1));
  await Future.delayed(Duration.zero); //Dùng để đảm bảo đợi xử lý sự kiện
  await listen1.cancel(); // Đóng Listen 1

  // Listen 2: Thực hiện truy cập data mỗi khi có thay đổi
  int num = 0;
  final listen2 = bloc.stream.listen((data) {
    num = data;
  });
  bloc.add(CounterDecrementPressed(1));
  bloc.add(CounterDecrementPressed(1));
  await Future.delayed(Duration.zero); //Dùng để đảm bảo đợi xử lý sự kiện
  print(num); // print số sau 2 lần add ở trên
  listen2.cancel(); // Đóng Listen 2

  await bloc.close(); // Đóng bloc
}
