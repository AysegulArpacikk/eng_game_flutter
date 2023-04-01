import 'package:equatable/equatable.dart';

abstract class CategoryPageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoryPageInitializeEvent extends CategoryPageEvent {}