

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';





class AddRecipesModel extends ChangeNotifier{
  TimeOfDay selectedTime = TimeOfDay.now();
  List<TimeOfDay> interval = [];
  late String pathPhoto;
  var tumbler = false;
  late XFile pickedFile;
  String avatar =  'images/pills.jpeg';

  /////////////////////////////////
  void addTime(BuildContext context) async {
    final timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial);
    if (timeOfDay != null) {
      interval.add(timeOfDay);
      notifyListeners();
    }
  }

  void delTime(int index){
    interval.removeAt(index);
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
              // _getFromCamera();
              Navigator.pop(context);
            }),
      ],
      cancelAction: CancelAction(
          title: const Text('Cancel', style: TextStyle(color: Colors.black))),
    );
  }

  _getFromGallery() async {
    final ImagePicker picker = ImagePicker();
    pickedFile = (await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    ))!;
    if (tumbler == true){File(avatar).delete();}
    Directory appDocDir = await getApplicationDocumentsDirectory();
    final Directory appDocDirFolder =  Directory('${appDocDir.path}/avatar_image');
    String appDocPath = appDocDirFolder.path;
    await File(pickedFile.path).copy('$appDocPath/${pickedFile.name}');
    avatar = '$appDocPath/${pickedFile.name}';
    File(pickedFile.path).delete();
    tumbler = true;
    notifyListeners();
  }

// загрузка из камеры
_getFromCamera() async {
  final ImagePicker picker = ImagePicker();
  pickedFile =
  (await picker.pickImage(source: ImageSource.camera,
    maxWidth: 1800,
    maxHeight: 1800,))!;
  if (tumbler == true){File(avatar).delete();}
  Directory appDocDir = await getApplicationDocumentsDirectory();
  final Directory appDocDirFolder =  Directory('${appDocDir.path}/avatar_image');
  String appDocPath = appDocDirFolder.path;
  await File(pickedFile.path).copy('$appDocPath/${pickedFile.name}');
  avatar = '$appDocPath/${pickedFile.name}';
  File(pickedFile.path).delete();
  tumbler = true;
  notifyListeners();
  }






}