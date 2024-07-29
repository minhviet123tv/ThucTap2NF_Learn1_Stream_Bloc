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
          //1. BlocBuilder: Dùng Data (dữ liệu) của CounterBloc cho UI
          BlocBuilder<CounterBloc, int>(
            builder: (BuildContext context, int dataState) {
              return Text(
                'Count: $dataState',
                style: const TextStyle(fontSize: 30),
              );
            },

            // buildWhen: So sánh trạng thái của dữ liệu ngay trước đó với hiện tại
            // để quyết định có sử dụng chức năng builder để cập nhật lại giao diện cho widget BlocBuilder này không
            // Mặc định là true (luôn sử dụng build lại widget này khi dữ liệu thay đổi)
            buildWhen: (previous, current) {
              if(previous == current){
                return false;
              } else {
                return true;
              }
            },
          ),

          //2. Dùng logic của CounterBloc
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context.read<CounterBloc>().add(CounterDecrement());
                  },
                  child: const Text("(-) Decrement")),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    // Thêm sự kiện cho CounterBloc bằng cách read CounterBloc từ context rồi add event (Bởi class tên event)
                    context.read<CounterBloc>().add(CounterIncrement());
                  },
                  child: const Text("(+) Increment")),
            ],
          ),

          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (builder) => const CounterPage2()));
              },
              child: const Text("Page 2 Of Counter")),
          const SizedBox(
            width: 10,
            height: 10,
          ),

          //III. BlocSelector: Sử dụng dữ liệu của Bloc để tạo ra trạng thái (bool, enum ...) rồi sử dụng các trạng thái đó
          BlocSelector<CounterBloc, int, bool>(
            //1. Sử dụng dữ liệu (int) để tạo các trạng thái (logic) kiểu bool
            selector: (data) {
              if (data > 5) {
                return true;
              } else {
                return false;
              }
            },

            //2. Xây dựng UI và sử dụng trạng thái đã tạo ở selector (state là kiểu bool)
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
            //1. Sử dụng dữ liệu (int) để tạo các trạng thái kiểu enum (tự tạo là MyBlocSelectorState)
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

            //2. Sử dụng trạng thái (kiểu enum MyBlocSelectorState)
            builder: (context, state) {
              return Container(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Center(
                      child: Text(
                        ' MyBlocSelectorState: ${state.name}',
                        style: const TextStyle(fontSize: 20),
                      ),
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
                ),
              );
            },
          ),
          const Divider(),

          //IV. BlocConsumer: Vừa sử dụng Bloc bằng cách lấy dữ liệu cho UI (vẫn có thể xử lý logic riêng và tự do)
          // lại vừa có phần xử lý logic phụ thuộc vào trạng thái data của Bloc đó
          BlocConsumer<CounterBloc, int>(
            //1. Sử dụng dữ liệu của Bloc cho UI
            builder: (context, state) {
              return Text(
                "$state",
                style: const TextStyle(fontSize: 20),
              );
            },

            //2. Tạo xử lý logic theo trạng thái dữ liệu của Bloc đó (thực hiện mỗi lần dữ liệu thay đổi)
            listener: (context, state) {
              if (state > 5) {
                print(">5");
              }
            },
          ),
          const Divider(),

          //V. BlocListener: Tạo mình logic theo trạng thái của dữ liệu của 1 Bloc, vị trí: đặt trong widget tree
          BlocListener<CounterBloc, int>(
            // listenWhen: Sử dụng giá trị hiện tại và trước đó của bloc | Trả về true hoặc false để quyết định có sử dụng chức năng listener hay không
            listenWhen: (previous, current) {
              print('$previous | $current');
              if (previous == current) {
                return true;
              } else {
                return false;
              }
            },

            // Tạo logic theo trạng thái của dữ liệu
            listener: (context, state) {
              if (state == 5) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("listener")));
              }
            },

            child: const Text(
              "Child of BlocListener",
              style: TextStyle(fontSize: 20),
            ),
          ),

          //VI. MultiBlocListener: Tạo logic theo trạng thái của dữ liệu cho nhiều Bloc khác nhau, chú ý vị trí đặt trong widget tree
          MultiBlocListener(
            listeners: [
              BlocListener<CounterBloc, int>(
                listener: (context, state) {
                  if (state == 5) {
                    print("state 5");
                  }
                },
              ),
              BlocListener<CounterBloc, int>(
                listener: (context, state) {
                  if (state == 6) {
                    print("state 6");
                  }
                },
              )
            ],
            child: const Text("Child of MultiBlocListener"),
          ),
        ],
      ),
    );
  }
}

