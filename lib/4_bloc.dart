import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
Bloc (Business Logic Component): quản lý một dữ liệu bằng các event sẽ được add vào, và lắng nghe sự thay đổi
 */

sealed class CounterEvent {} // Tên sự kiện chính

// Các câu lệnh (event) thực hiện của sự kiện chính (Có thể có dữ liệu, hàm bên trong)
final class CounterIncrementPressed extends CounterEvent {
  late int number;
  CounterIncrementPressed(this.number);
}
final class CounterDecrementPressed extends CounterEvent {
  late int number;
  CounterDecrementPressed(this.number);
}

//I. Tạo Bloc, cấu trúc extends Bloc<CustomEvent, int>: Các event của CustomEvent được tạo như một hoặc nhiều câu lệnh
// dưới dạng class extends CustomEvent (có thể có dữ liệu bên trong để sử dụng khi tạo)
class CounterBloc extends Bloc<CounterEvent, int> {

  // Chỉ định trạng thái ban đầu (như Cubit)
  CounterBloc() : super(10) {

    // Đăng ký trình xử lý sự kiện thông qua on<Event>
    on<CounterIncrementPressed>((event, emit){
      emit(state + event.number); // Phản hồi sự kiện : quản lý tất cả sự kiện CounterIncrementPressed
    });

    on<CounterDecrementPressed>((event, emit){
      emit(state - event.number);
    });
  }

  // onEvent: được gọi ngay khi sự kiện được thêm vào
  @override
  void onEvent(CounterEvent event) {
    super.onEvent(event);
    print('$event - by onEvent in Bloc');
  }

  // onTransition: Quan sát sự thay đổi trước, sau của dữ liệu và cả nguyên nhân (sự kiện) tạo ra sự thay đổi
  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    super.onTransition(transition);
    print('$transition - by onTransition in Bloc');
  }

  // onChange: Quan sát sự thay đổi trước và sau của dữ liệu mà Bloc quản lý
  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print('$change - by onChange in Bloc');
  }

  // onError: chỉ ra rằng đã xảy ra lỗi (Hoạt động cùng lúc với onChange)
  @override
    void onError(Object error, StackTrace stackTrace) {
      super.onError(error, stackTrace);
      print('$error, $stackTrace - by onChange in Bloc');
    }


}

//II.1 Sử dụng Bloc<CounterEvent, int>, tự print sau mỗi lần thực hiện event (thay đổi trạng thái)
Future<void> main1() async {

  final bloc = CounterBloc();
  print(bloc.state); // Trạng thái trước khi thực hiện event

  // Thực hiện event CounterIncrementPressed cho bloc
  bloc.add(CounterIncrementPressed(5));
  await Future.delayed(Duration.zero); //Dùng để đảm bảo đợi xử lý sự kiện
  print(bloc.state); // Trạng thái sau khi thực hiện event

  // Thực hiện CounterDecrementPressed cho bloc, sử dụng dữ liệu bên trong CounterDecrementPressed
  bloc.add(CounterDecrementPressed(1));
  await Future.delayed(Duration.zero); //Dùng để đảm bảo đợi xử lý sự kiện
  print(bloc.state); // Trạng thái sau khi thực hiện event

  await bloc.close(); // Đóng bloc
}

//II.2 Sử dụng bloc và dùng listen để lắng nghe trạng thái | Hoặc truy cập dữ liệu của bloc bằng: bloc.stream.listen((data){});
Future<void> main2() async {
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
  final listen2 = bloc.stream.listen((data){num = data;});
  bloc.add(CounterDecrementPressed(1));
  bloc.add(CounterDecrementPressed(1));
  await Future.delayed(Duration.zero); //Dùng để đảm bảo đợi xử lý sự kiện
  print(num); // print số sau 2 lần add ở trên
  listen2.cancel(); // Đóng Listen 2

  await bloc.close(); // Đóng bloc
}

//II.3 Sử dụng đơn giản Bloc
void main3() {
  CounterBloc()..add(CounterIncrementPressed(1))..close();
}

//III.1 Tạo khối quan sát toàn bộ dữ liệu các Bloc khi có trạng thái cập nhật (Tương tự Cubit)
class SimpleBlocObserver extends BlocObserver {

  // onEvent: được gọi ngay khi sự kiện được thêm vào
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('$bloc $event - by BlocObserver');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('${bloc.runtimeType} $transition  - by BlocObserver');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change  - by BlocObserver');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType} $error $stackTrace - by BlocObserver');
    super.onError(bloc, error, stackTrace);
  }
}

//III.2 Dùng SimpleBlocObserver
void main() {
  // Bloc.observer = SimpleBlocObserver();
  CounterBloc()
    ..add(CounterIncrementPressed(1))
    ..close();
}