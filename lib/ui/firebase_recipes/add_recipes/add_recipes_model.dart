import 'package:doctor/entity/course.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:image_picker/image_picker.dart';
import '../../../api/firebase_api/firebase_api.dart';

class AddRecipesModel extends ChangeNotifier {
  TimeOfDay selectedTime = TimeOfDay.now();
  String namePill = '';
  String descriptionPill = '';
  List<String> timeOfReceipt = [];
  var tumbler = false;
  late XFile? pickedFile;
  String photoPill = 'images/pills.jpg';
  final userId = FirebaseAuth.instance.currentUser?.uid;



  Future<String> compliteCourseAndToFirebase() async {
    if (userId  != null &&
        namePill != '' &&
        descriptionPill != '' &&
        photoPill != 'images/pills.jpg'&&
        timeOfReceipt != []) {
      photoPill =await FireBaseApi.loadImageOnStorage(pickedFile!);
      Course course = Course(
          idUser: userId ?? '',
          namePill: namePill,
          descriptionPill: descriptionPill,
          photoPill: photoPill,
          timeOfReceipt: timeOfReceipt,
          namePhotoPillInStorage: pickedFile!.name);
      String error = await FireBaseApi.createCourse(course);
      return error;
    } else {
      return 'Не заполнены все поля';
    }
  }

  /////////////////////////////////
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

  TimeOfDay fromString(String time) {
    int hh = 0;
    if (time.endsWith('PM')) hh = 12;
    time = time.split(' ')[0];
    return TimeOfDay(
      hour: hh +
          int.parse(time.split(":")[0]) %
              24, // in case of a bad time format entered manually by the user
      minute: int.parse(time.split(":")[1]) % 60,
    );
  }

  void delTime(int index) {
    timeOfReceipt.removeAt(index);
    notifyListeners();
  }
///////////////////////////////////

  //меню выбора
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

}
