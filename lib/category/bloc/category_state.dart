import 'package:equatable/equatable.dart';

abstract class CategoryPageState extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoryPageInitialState extends CategoryPageState {}

class CategoriesFetchedState extends CategoryPageState {
  List<dynamic> categories;

  CategoriesFetchedState({required this.categories});

  @override
  String toString() {
    return 'CategoriesFetchedState{categories: $categories}';
  }

  @override
  List<Object> get props => [categories];
}

