import 'dart:convert';

import 'package:eng_game_flutter/login/bloc/login_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  LoginPageBloc() : super(LoginPageInitialState());

  @override
  Stream<LoginPageState> mapEventToState(LoginPageEvent event) async* {
    String response = await rootBundle.loadString("assets/json/username_list.json");
    final data = await json.decode(response);

    if(event is LoginPageInitializeEvent) {
      yield LoginPageInitialState();
    } else if (event is LoginEvent) {
      yield SuccessLoginState();
    } else if (event is LoginOrRegisterPageInitializeEvent) {
      yield LoginOrRegisterInitialState();
    }
  }

}