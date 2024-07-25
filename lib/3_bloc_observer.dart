import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_bloc/2_cubit_learn.dart';

///1.1 Cubit dùng cả onChange và onError
class CounterCubit4 extends Cubit<int> {
  CounterCubit4() : super(0);

  void increment() => emit(state + 1);

  //onChange: Quan sát thay đổi của Cubit bằng hàm onChange của riêng Cubit này, trước và sau khi thay đổi (chú ý định dạng dữ liệu)
  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print(change); // print thay đổi
  }

  // onError: Chỉ ra lỗi đã xảy ra
  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print('$error - $stackTrace');
  }

}

///1.2 Sử dụng CounterCubit4
// void main() {
//   CounterCubit4()
//     ..increment()
//     ..close();
// }

///2.1 BlocObserver: Truy cập Changes, onError của tất cả các Cubit khi chúng được sử dụng
class SimpleBlocObserver extends BlocObserver {

  // onEvent: Ghi đè
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('${bloc.runtimeType} $event');
  }
  
  // onChange toàn app
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} - $change  (onChange by SimpleBlocObserver)'); // runtimeType: Kiểu định dạng (class của Cubit được dùng)
  }
  
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('${bloc.runtimeType} - $error - $stackTrace (onError by SimpleBlocObserver)');
  }

}

///2.2 Sử dụng SimpleBlocObserver cho các Cubit
void main() {

  // Chỉ cần tạo là sẽ được sử dụng
  Bloc.observer = SimpleBlocObserver();

  CounterCubit4()
    ..increment()
    ..close();

  CounterCubit3()
  ..increment()
  ..close();

  // => Như vậy BlocObserver sẽ gọi tất cả 1 lần nữa | Còn onChange của mỗi Cubit vẫn thực hiện
}