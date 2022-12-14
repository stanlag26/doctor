import 'package:doctor/ui/main_widget/main_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth/forget_password/forget_password.dart';
import 'auth/sing_in_reg/sing_in_reg.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Doctor',
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/',
      routes: {
        '/': (context) =>  const MainProviderWidget(),
        '/sign-in': (context) =>  const  RegisterSingInProviderWidget(),
        '/sign-in/forgot': (context) =>  ForgotWidget(),



      },);
  }
}
