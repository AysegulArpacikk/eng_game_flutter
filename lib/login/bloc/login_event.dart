import 'package:equatable/equatable.dart';

abstract class LoginPageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class LoginPageInitializeEvent extends LoginPageEvent {}

class LoginEvent extends LoginPageEvent {
  final String userName;

  LoginEvent({this.userName = ""});
}

class LoginOrRegisterPageInitializeEvent extends LoginPageEvent {}
