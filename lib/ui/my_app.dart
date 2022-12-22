import 'package:doctor/ui/main_widget/main_widget.dart';
import 'package:doctor/ui/my_courses/hive_courses.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../const/const.dart';
import 'auth/forget_password/forget_password.dart';
import 'auth/sing_in_reg/sing_in_reg.dart';
import 'firebase_recipes/add_recipes/add_recipes.dart';
import 'firebase_recipes/one_recipe/one_recipe.dart';
import 'firebase_recipes/recipes/recipes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme:  AppBarTheme(
            elevation: 0,
            backgroundColor: Colors.white10,
            iconTheme: const IconThemeData(color: Colors.grey, size: 15),
            titleTextStyle: MyTextStyle.textStyle25),),
      debugShowCheckedModeBanner: false,
      title: 'Doctor',
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/sign-in' : '/',
      routes: {
        '/': (context) =>  const MainProviderWidget(),
        '/sign-in': (context) =>  const  RegisterSingInProviderWidget(),
        '/sign-in/forgot': (context) =>  ForgotWidget(),
        '/recides': (context) =>  RecipesProviderWidget(),
        '/recides/add': (context) =>  const AddRecipesProviderWidget(),
        '/recides/one': (context) =>  const OneRecipesProviderWidget(),
        '/courses': (context) =>  const CoursesProviderWidget(),




      },);
  }
}
