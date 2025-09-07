import 'package:equatable/equatable.dart';

abstract class A1PageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class A1PageInitializeEvent extends A1PageEvent {}