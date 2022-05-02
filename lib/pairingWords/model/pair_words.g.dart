// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pair_words.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EngQuestionWord _$EngQuestionWordFromJson(Map<String, dynamic> json) =>
    EngQuestionWord(
      id: json['id'] as int? ?? 1,
      code: json['code'] as String? ?? "",
      name: json['name'] as String? ?? "",
      correctAnswer: json['correctAnswer'] as String? ?? "",
      answers: (json['answers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$EngQuestionWordToJson(EngQuestionWord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'correctAnswer': instance.correctAnswer,
      'answers': instance.answers,
    };
