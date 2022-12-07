
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterSingInModel extends ChangeNotifier{
  bool regOn = false;
  String error = '';


  void tumbler(){
    regOn = !regOn;
    notifyListeners();
  }


  Future<String?> mailRegister(String mail, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: mail, password: password);
      return null;
    } on FirebaseAuthException catch (ex) {
      print("${ex.code}: ${ex.message}");
      return error = "${ex.code}: ${ex.message}";
    }
  }

  Future<String?> mailSingIn(String mail, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: password);
      return null;
    } on FirebaseAuthException catch (ex) {
      print("${ex.code}: ${ex.message}");
      return error = "${ex.code}: ${ex.message}";
    }
  }












}