import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pair_words.g.dart';

@JsonSerializable()
class EngQuestionWord extends Equatable{
  final int id;
  final String code;
  final String name;
  final String correctAnswer;
  final String imageUrl;
  final List<String> answers;

  EngQuestionWord({this.id = 1, this.code = "", this.name = "", this.correctAnswer = "", this.imageUrl = "", this.answers = const []});

  factory EngQuestionWord.fromJson(Map<String, dynamic> json) => _$EngQuestionWordFromJson(json);

  Map<String, dynamic> toJson() => _$EngQuestionWordToJson(this);

  @override
  List<Object?> get props => [id, code, name, correctAnswer, imageUrl, answers];
}