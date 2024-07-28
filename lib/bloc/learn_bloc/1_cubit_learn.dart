import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*
Cubit chỉ quản lý một dữ liệu
 */

//1. Tạo Cubit chỉ định trạng thái ban đầu
class CounterCubit1 extends Cubit<int> {
  CounterCubit1() : super(0);
}

//2.1 Tạo Cubit Chấp nhận giá trị bên ngoài
class CounterCubit2 extends Cubit<int> {
  CounterCubit2(int initialState) : super(initialState);
}

///2.2 Tạo CounterCubit2
// void main() {
//   // Tạo CounterCubit2 với giá trị bên ngoài
//   final cubitA = CounterCubit2(0); // state starts at 0
//   final cubitB = CounterCubit2(10); // state starts at 10
// }

//3.1 Tạo Cubit có thay đổi trạng thái: Trạng thái mới thông qua emit
class CounterCubit3 extends Cubit<int> {
  CounterCubit3() : super(0); // Trạng thái ban đầu là 0

  void increment() => emit(state + 1); // state: trạng thái hiện tại | emit (chỉ sử dụng bên trong Cubit): trạng thái mới
}

///3.2 Tạo và sử dụng CounterCubit3
// void main() {
//   // Tạo và sử dụng CounterCubit3
//   final cubit = CounterCubit3();
//   print(cubit.state);
//   cubit.increment();
//   print(cubit.state);
//   cubit.close(); // Đóng luồng trạng thái nội bộ
// }

///3.3 Sử dụng CounterCubit3 và dùng listen để lắng nghe trạng thái
// Future<void> main() async {
//   final cubit = CounterCubit3();
//   final subscription = cubit.stream.listen(print); // Gọi phương thức print trên mỗi thay đổi trạng thái
//
//   cubit.increment(); // Phát trạng thái mới
//   await Future.delayed(Duration.zero); // Thời gian chờ | Được thêm vào ví dụ này để tránh việc hủy đăng ký ngay lập tức.
//
//   await subscription.cancel(); // Không cập nhật nữa
//   await cubit.close(); // Đóng Cubit
// }
