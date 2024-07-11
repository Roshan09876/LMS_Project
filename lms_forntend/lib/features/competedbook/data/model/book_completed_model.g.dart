// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_completed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookCompletedModel _$BookCompletedModelFromJson(Map<String, dynamic> json) =>
    BookCompletedModel(
      json['id'] as String?,
      json['title'] as String?,
      json['subtitle'] as String?,
      json['description'] as String?,
      json['image'] as String?,
      json['course'] as String?,
      json['level'] as String?,
    );

Map<String, dynamic> _$BookCompletedModelToJson(BookCompletedModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'description': instance.description,
      'image': instance.image,
      'course': instance.course,
      'level': instance.level,
    };
