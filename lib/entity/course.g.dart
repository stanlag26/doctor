// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: json['id'] as String,
      namePill: json['namePill'] as String,
      descriptionPill: json['descriptionPill'] as String,
      photoPill: json['photoPill'] as String,
      timeOfReceipt: (json['timeOfReceipt'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'namePill': instance.namePill,
      'descriptionPill': instance.descriptionPill,
      'photoPill': instance.photoPill,
      'timeOfReceipt': instance.timeOfReceipt,
    };
