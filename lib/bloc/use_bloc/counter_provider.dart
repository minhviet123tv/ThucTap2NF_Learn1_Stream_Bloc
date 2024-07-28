import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '1_bloc_counter.dart';

/*
BlocProvider sẽ quản lý, chứa 1 Bloc sẽ được sử dụng | Khi dùng MultiBlocProvider thì không cần tạo class riêng nữa
 */
class CounterProvider extends StatelessWidget {

  final Widget child;
  const CounterProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
      create: (context) => CounterBloc(),
      child: child,
    );
  }
}
