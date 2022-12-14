import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable()
class Course{
  late final String id;
  late final String namePill;
  late final String descriptionPill;
  late final String photoPill;
  late final List <String> timeOfReceipt;

  Course({
    required this.id,
    required this.namePill,
    required this.descriptionPill,
    required this.photoPill,
    required this.timeOfReceipt,
  });

  @override
  String toString() => 'Название: $namePill, Описание: $descriptionPill, Фото: $photoPill,  Прием: $timeOfReceipt';

factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);



  }