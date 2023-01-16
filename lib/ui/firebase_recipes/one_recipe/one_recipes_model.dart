

import 'dart:io';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:doctor/entity/course_hive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../api/firebase_api/firebase_api.dart';
import '../../../entity/course.dart';

class OneRecipesModel extends ChangeNotifier{

  TimeOfDay selectedTime = TimeOfDay.now();
  String idDoc = '';
  String namePill = '';
  String namePhotoPillInStorage = '';
  String descriptionPill = '';
  List<String> timeOfReceipt = [];
  XFile? pickedFile;
  String photoPill = 'images/pills.jpg';
  var tumbler = false;
  final userId = FirebaseAuth.instance.currentUser?.uid;



  Future<String> editCourseAndToFirebase() async {
    if (userId  != null &&
        namePill != '' &&
        descriptionPill != '' &&
        photoPill != 'images/pills.jpg') {
      photoPill = tumbler == true ? await FireBaseApi.reLoadImageOnStorage( pickedFile!, namePhotoPillInStorage):
      photoPill;
      Course course = Course(
          idDoc: idDoc,
          idUser: userId ?? '',
          namePill: namePill,
          descriptionPill: descriptionPill,
          photoPill: photoPill,
          timeOfReceipt: timeOfReceipt,
          namePhotoPillInStorage: tumbler == true ? pickedFile!.name
             :namePhotoPillInStorage);
      String error = await FireBaseApi.editCourse(course);
      return error;
    } else {
      return 'Не заполнены все поля';
    }
  }

  void addTime(BuildContext context) async {
    final timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial);
    if (timeOfDay != null) {
      timeOfReceipt.add(timeOfDay.toString());
      notifyListeners();
    }
  }

  void delTime(int index) {
    timeOfReceipt.removeAt(index);
    notifyListeners();
  }

  void myShowAdaptiveActionSheet(BuildContext context) {
    showAdaptiveActionSheet(
      context: context,
      title: const Text('Добавить фото'),
      androidBorderRadius: 30,
      actions: <BottomSheetAction>[
        BottomSheetAction(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.photo),
              SizedBox(
                width: 10,
              ),
              Text('Галерея'),
            ],
          ),
          onPressed: (BuildContext context) {
            _getFromGallery();
            Navigator.pop(context);
          },
        ),
        BottomSheetAction(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.camera_alt_outlined,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Камера',
                ),
              ],
            ),
            onPressed: (BuildContext context) {
              _getFromCamera();
              Navigator.pop(context);
            }),
      ],
      cancelAction: CancelAction(
          title: const Text('Cancel', style: TextStyle(color: Colors.black))),
    );
  }

  _getFromGallery() async {
    if (tumbler == true) {
      File(pickedFile!.path).delete();
    }
    final ImagePicker picker = ImagePicker();
    pickedFile = (await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 100,
    ));
    if (pickedFile != null) {

      photoPill = pickedFile!.path;
      print(pickedFile!.path);
      tumbler = true;
      notifyListeners();
    } else {
      return;
    }
  }

  _getFromCamera() async {
    if (tumbler == true) {
      File(pickedFile!.path).delete();
    }
    final ImagePicker picker = ImagePicker();
    pickedFile = (await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 100,
    ));
    if (pickedFile != null) {

      photoPill = pickedFile!.path;
      print(pickedFile!.path);
      tumbler = true;
      notifyListeners();
    } else {
      return;
    }
  }


  void saveCoursesToHive( BuildContext context) async{
    final box = await Hive.openBox<CourseHive>('courses_box');
    final String photoPillHive = await FireBaseApi.downloadFile(namePhotoPillInStorage);
    final course = CourseHive(namePill: namePill, descriptionPill: descriptionPill, photoPill: photoPillHive, timeOfReceipt: timeOfReceipt);
    await box.add(course);//  добавляем сохраненную группу в список

    Navigator.pushNamed(context, '/');
  }



}