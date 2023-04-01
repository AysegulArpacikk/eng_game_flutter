import 'package:equatable/equatable.dart';

abstract class LoginPageState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginPageInitialState extends LoginPageState {}

class SuccessLoginState extends LoginPageState {}

class LoginOrRegisterInitialState extends LoginPageState{}
