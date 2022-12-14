


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
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

  static Future <String> loadImageOnStorage (XFile pickedFile, String namePill) async {
      final storageRef = FirebaseStorage.instance.ref();
      final referenceDirImage = storageRef.child('images');
      final referenceImageToUpload = referenceDirImage.child(namePill);
      try {
      await referenceImageToUpload.putFile(File(pickedFile.path));
      File(pickedFile.path).delete();
      String photoPill = await referenceImageToUpload.getDownloadURL() ;
      return photoPill;
      } on FirebaseException catch (e) {
        return "${e.code}:${e.message}";
      }
  }


}