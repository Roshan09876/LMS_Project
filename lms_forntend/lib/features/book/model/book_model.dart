// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'book_model.g.dart';

@JsonSerializable()
class BookModel {
  final String? title;
  final String? subtitle;
  final String? description;
  final String? image;
  final String? course;
  BookModel({
    this.title,
    this.subtitle,
    this.description,
    this.image,
    required this.course,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => _$BookModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookModelToJson(this);
}
