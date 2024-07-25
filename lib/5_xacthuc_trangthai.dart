import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthenticationState { unknown, authenticated, unauthenticated }


/// VD:
// Transition {
// currentState: AuthenticationState.authenticated,
// event: LogoutRequested,
// nextState: AuthenticationState.unauthenticated
// }