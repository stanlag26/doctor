


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../entity/course.dart';

class FireBaseApi {

  static Future <String> createCourse (Course course) async {
    try{
    final docCourse = FirebaseFirestore.instance.collection('Course').doc();
    await  docCourse.set(course.toJson());
    return '';}
    on FirebaseException catch (e) {
      // Caught an exception from Firebase.
      return "${e.code}:${e.message}";
    }
  }

  static Future <String> loadImageOnStorage (XFile pickedFile ) async {
      final storageRef = FirebaseStorage.instance.ref();
      final referenceDirImage = storageRef.child('images');
      final referenceImageToUpload = referenceDirImage.child(pickedFile.name);
      try {
      await referenceImageToUpload.putFile(File(pickedFile.path));
      File(pickedFile.path).delete();
      String photoPill = await referenceImageToUpload.getDownloadURL() ;
      return photoPill;
      } on FirebaseException catch (e) {
        return "${e.code}:${e.message}";
      }
  }


  static Future<String> delCourse (Course course) async {
    try{
      await FirebaseFirestore.instance.collection('Course').doc(course.idDoc).delete();
      // Create a reference to the file to delete
      final storageRef = FirebaseStorage.instance.ref();
      final desertRef = storageRef.child('images/${course.namePhotoPillInStorage}');
      // Delete the file
      await desertRef.delete();
      return '';
   }
    on FirebaseException catch (e) {
      // Caught an exception from Firebase.
      return "${e.code}:${e.message}";
    }
  }

  static Future<String> editCourse (Course course) async {
    try{
      final docCourse = FirebaseFirestore.instance.collection('Course').doc(course.idDoc);
      await  docCourse.set(course.toJson());
      return '';}
    on FirebaseException catch (e) {
      // Caught an exception from Firebase.
      return "${e.code}:${e.message}";
    }
  }

  static Future <String> reLoadImageOnStorage (XFile pickedFile, String namePhotoPillInStorage  ) async {
    // Создаем ссылку на хранилище из нашего приложения
    final storageRef = FirebaseStorage.instance.ref();
    // Удаляем файл со старым именем
    await storageRef.child('images/$namePhotoPillInStorage').delete();

    final referenceDirImage = storageRef.child('images');
    final referenceImageToUpload = referenceDirImage.child(pickedFile.name);

       await referenceImageToUpload.putFile(File(pickedFile.path));
       File(pickedFile.path).delete();
       String photoPill = await referenceImageToUpload.getDownloadURL();
       return photoPill;
  }


  static Future downloadFile (String namePhotoPillInStorage) async {
    final storageRef = FirebaseStorage.instance.ref();
    final ref = storageRef.child('images/$namePhotoPillInStorage');
    final dir = await getApplicationDocumentsDirectory();
    final file =  File('${dir.path}/${ref.name}');
    print('${dir.path}/${ref.name}');
    await ref.writeToFile(file);
    return '${dir.path}/${ref.name}';
    
    // ScaffoldMessenger.of(context).showSnackBar(context: Text('Download ${ref.name}'));

  }




}

