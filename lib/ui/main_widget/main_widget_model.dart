
import 'package:flutter/material.dart';

import '../firebase_recipes/recipes/recipes.dart';
import '../my_courses/courses/hive_courses.dart';

class MainWidgetModel extends ChangeNotifier{
  int selectedIndex = 0;

 void onItemTapped(value) {
     selectedIndex = value;
     notifyListeners();
 }


 List<Widget> widgetOptions = <Widget>[
   CoursesProviderWidget(),
   RecipesProviderWidget(),
  ];


}