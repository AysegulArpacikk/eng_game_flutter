import 'package:equatable/equatable.dart';

abstract class A1PageState extends Equatable {
  @override
  List<Object> get props => [];
}

class A1PageInitialState extends A1PageState {}

class A1FetchedState extends A1PageState {
  List<dynamic> a1Questions;

  A1FetchedState({required this.a1Questions});

  @override
  String toString() {
    return 'A1FetchedState{a1Questions: $a1Questions}';
  }

  @override
  List<Object> get props => [a1Questions];
}
