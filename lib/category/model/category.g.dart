// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      name: json['name'] as String? ?? "",
      questions: (json['questions'] as List<dynamic>?)
              ?.map((e) => EngQuestionWord.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'name': instance.name,
      'questions': instance.questions,
    };

Categories _$CategoriesFromJson(Map<String, dynamic> json) => Categories(
      categories: json['categories'] as List<dynamic>? ?? const [],
    );

Map<String, dynamic> _$CategoriesToJson(Categories instance) =>
    <String, dynamic>{
      'categories': instance.categories,
    };
