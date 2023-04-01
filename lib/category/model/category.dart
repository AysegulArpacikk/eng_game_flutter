import 'package:eng_game_flutter/pairingWords/model/pair_words.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category extends Equatable{
  final String name;
  final List<EngQuestionWord> questions;

  const Category({this.name = "", this.questions = const []});

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @override
  List<Object?> get props => [name, questions];
}

@JsonSerializable()
class Categories extends Equatable {
  final List<dynamic> categories;

  const Categories({this.categories = const []});

  factory Categories.fromJson(Map<String, dynamic> json) => _$CategoriesFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesToJson(this);

  @override
  List<Object?> get props => [categories];
}
