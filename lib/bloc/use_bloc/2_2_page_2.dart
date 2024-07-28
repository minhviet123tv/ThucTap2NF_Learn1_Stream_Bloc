import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '1_bloc_counter.dart';
import '2_1_page_1.dart';

// Page 2: Thể hiện lại Page 1, chứng minh trạng thái được thể hiện ở nhiều trang
class CounterPage2 extends StatefulWidget {
  const CounterPage2({super.key});

  @override
  State<CounterPage2> createState() => _CounterPage2State();
}

class _CounterPage2State extends State<CounterPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page 2"),
        backgroundColor: Colors.blue,
      ),

      //II. BlocBuilder: sử dụng Bloc (CounterBloc)
      body: Column(
        children: [
          BlocBuilder<CounterBloc, int>(
            builder: (BuildContext context, int dataState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Count: $dataState',
                    style: const TextStyle(fontSize: 30),
                  ), // Lấy được dữ liệu của CounterBloc
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            context.read<CounterBloc>().add(CounterDecrement());
                          },
                          child: const Text("Decrement")),
                      const SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            // Thêm sự kiện cho CounterBloc bằng cách read từ context rồi add event (Bởi class tên event)
                            context.read<CounterBloc>().add(CounterIncrement());
                          },
                          child: const Text("Increment")),
                    ],
                  ),
                ],
              );
            },
          ),
          const SizedBox(
            width: 10,
            height: 10,
          ),

          //III. BlocSelector: Sử dụng Bloc theo trạng thái của dữ liệu
          BlocSelector<CounterBloc, int, bool>(
            selector: (data) {
              if (data > 5) {
                return true;
              } else {
                return false;
              }
            },
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ' State > 5: $state',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                    height: 10,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    color: state ? Colors.green : Colors.orange,
                  ),
                ],
              );
            },
          ),
          const SizedBox(
            width: 10,
            height: 10,
          ),

          BlocSelector<CounterBloc, int, MyBlocSelectorState>(
            selector: (data) {
              switch (data) {
                case 1:
                  return MyBlocSelectorState.one;
                case 2:
                  return MyBlocSelectorState.two;
                case 3:
                  return MyBlocSelectorState.three;
                default:
                  return MyBlocSelectorState.different;
              }
            },
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ' MyBlocSelectorState: ${state.name}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                    height: 10,
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: () {
                        if (state == MyBlocSelectorState.one) {
                          return Colors.blue;
                        }
                        if (state == MyBlocSelectorState.two) {
                          return Colors.black;
                        }
                        if (state == MyBlocSelectorState.three) {
                          return Colors.pink;
                        }
                        if (state == MyBlocSelectorState.different) {
                          return Colors.purpleAccent;
                        }
                      }(),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              );
            },
          ),
          const Divider(),

          //IV. BlocConsumer: Vừa sử dụng Bloc bằng cách lấy dữ liệu cho UI (vẫn có thể xử lý logic riêng và tự do)
          // lại vừa có phần xử lý logic phụ thuộc vào trạng thái data của Bloc đó
          BlocConsumer<CounterBloc, int>(
            //1. Sử dụng dữ liệu của Bloc cho UI
            builder: (context, state) {
              if (state > 5) {
                return const Text(
                  "> 5",
                  style: TextStyle(fontSize: 20),
                );
              } else {
                return Text(
                  "$state",
                  style: TextStyle(fontSize: 20),
                );
              }
            },

            //2. Xử lý logic phụ thuộc trạng thái dữ liệu của Bloc đó
            listener: (context, state) {
              if (state > 5) {
                print(">5");
              } else {
                print(state);
              }
            },
          )
        ],
      ),
    );
  }
}

