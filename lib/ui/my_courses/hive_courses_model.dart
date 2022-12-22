
import 'package:doctor/entity/course_hive.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class CoursesModel extends ChangeNotifier {

  var _courses = <CourseHive>[];

  List <CourseHive> get courses => _courses.toList();

  CoursesModel() {
    _setup();
  }


  void _readCoursesFromHive(Box<CourseHive> box) {
    _courses = box.values.toList();
    notifyListeners();
  }

  void _setup() async {
    final box = await Hive.openBox<CourseHive>('courses_box');
    _readCoursesFromHive(box);
    box.listenable().addListener(() => _readCoursesFromHive(box));
  }

  void deleteCourse(int index) async {
    final box = await Hive.openBox<CourseHive>('courses_box');
    final course = box.getAt(index) as CourseHive;
    final file =  File(course.photoPill);
    await box.deleteAt(index);
  }


}