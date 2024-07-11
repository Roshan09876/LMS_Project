import 'package:json_annotation/json_annotation.dart';

part 'book_completed_model.g.dart';

@JsonSerializable()
class BookCompletedModel {
  @JsonKey()
  final String? id;
  final String? title;
  final String? subtitle;
  final String? description;
  final String? image;
  final String? course;
  final String? level;

  BookCompletedModel(
    this.id,
    this.title,
    this.subtitle,
    this.description,
    this.image,
    this.course,
    this.level,
  );

  factory BookCompletedModel.fromJson(Map<String, dynamic> json) =>
      _$BookCompletedModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookCompletedModelToJson(this);
}
