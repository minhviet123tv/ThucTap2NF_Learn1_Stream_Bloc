import 'package:flutter/material.dart';

/*
- Luồng (Stream) là một danh sách dữ liệu không đồng bộ (dữ liệu không có mặt đồng thời cùng lúc mà xuất hiện tích luỹ dần).
https://bloclibrary.dev/bloc-concepts/#using-a-bloc
 */

void main() async {
  // Print các phần tử bên trong stream
  await countStream(5).forEach((element) {
    print(element);
  });

  // Tổng các phần tử bên trong Stream
  print(await sumStream(countStream(10)));
}

//1. Stream: Luồng dữ liệu
Stream<int> countStream(int max) async* {
  for (int i = 0; i < max; i++) {
    yield i; // Đẩy dữ liệu vào Stream
  }
}

//2. Tổng các phần tử của một Stream
Future<int> sumStream(Stream<int> stream) async {
  int sum = 0;
  await stream.forEach((element) {
    sum += element;
  });
  return sum;
}
