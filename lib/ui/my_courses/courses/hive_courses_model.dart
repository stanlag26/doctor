import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:doctor/entity/course_hive.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'dart:io';
import '../../../api/awesome_notifications_push/notifications.dart';

class CoursesModel extends ChangeNotifier {
  var _courses = <CourseHive>[];

  List<CourseHive> get courses => _courses.toList();

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
    saveCoursesToPush();
    box.listenable().addListener(() => _readCoursesFromHive(box));
  }

  void deleteCourse(int index) async {
    final box = await Hive.openBox<CourseHive>('courses_box');
    final course = box.getAt(index) as CourseHive;
    final file = File(course.photoPill);
    await box.deleteAt(index);
  }

  void saveCoursesToPush() async {
    await Noti.cancelScheduledNotifications();
    int _count = 0;
    for (int data = 0; data < _courses.length; data++) {
      for (int idTime = 0;
          idTime < courses[data].timeOfReceipt.length;
          idTime++) {
        await Noti.createNotification(
            id: _count++,
            name: 'Время приема ${_courses[data].namePill}а',
            description: _courses[data].descriptionPill,
            photo: _courses[data].photoPill,
            hour: int.parse(
                _courses[data].timeOfReceipt[idTime].substring(10, 12)),
            minute: int.parse(
                _courses[data].timeOfReceipt[idTime].substring(13, 15)));
      }
    }
    print(_count);
  }
}
