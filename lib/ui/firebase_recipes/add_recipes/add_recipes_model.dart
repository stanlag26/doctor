

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class AddRecipesModel extends ChangeNotifier{
  TimeOfDay selectedTime = TimeOfDay.now();
  List<TimeOfDay> interval = [];
  late String pathPhoto;








  void addTime(BuildContext context) async {
    final timeOfDay = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        initialEntryMode: TimePickerEntryMode.dial);
    if (timeOfDay != null) {
      interval.add(timeOfDay);
      notifyListeners();
      print(interval);
    }
  }

  void delTime(int index){
    interval.removeAt(index);
    notifyListeners();
  }

}