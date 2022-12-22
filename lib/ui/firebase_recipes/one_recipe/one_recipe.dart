

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../../api/firebase_api/firebase_api.dart';
import '../../../const/const.dart';
import '../../../entity/course.dart';
import '../../../my_widgets/my_avatar_photo.dart';
import '../../../my_widgets/my_button.dart';
import '../../../my_widgets/my_text_field.dart';
import 'one_recipes_model.dart';

class OneRecipesProviderWidget extends StatelessWidget {
  const OneRecipesProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Course course = ModalRoute.of(context)!.settings.arguments as Course;
    return ChangeNotifierProvider(create: (context) => OneRecipesModel(),
        child:  OneRecipes(course: course,));
  }
}


class OneRecipes extends StatelessWidget {
 late Course course;
  OneRecipes({Key? key, required this.course}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final model = context.watch<OneRecipesModel>();
    model.idDoc = course.idDoc;
    model.namePhotoPillInStorage = course.namePhotoPillInStorage;
   if (model.tumbler == false) {
    model.photoPill = course.photoPill;
    model.namePill = course.namePill;
    model.descriptionPill = course.descriptionPill;
    model.timeOfReceipt = course.timeOfReceipt;}
    final TextEditingController namePillController = TextEditingController(text: model.namePill);
    final TextEditingController descriptionPillController = TextEditingController(text: model.descriptionPill);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            course.namePill,
            style: MyTextStyle.textStyle25,
          ),
          actions: [
            IconButton(onPressed: () {
              showDialog(
                  // barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return Center(child: CircularProgressIndicator(),);
                  });
              model.saveCoursesToHive(context);

            },
                icon: Icon(FontAwesomeIcons.plus, size: 25)),
            IconButton(
                onPressed: ()  async {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return Center(child: CircularProgressIndicator(),);
                      });

                  String error = await model.editCourseAndToFirebase();

                  if (error!= '') {
                    Navigator.of(context, rootNavigator: true).pop();
                    Fluttertoast.showToast(
                        msg: error,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    Navigator.of(context, rootNavigator: true).pop();
                    Navigator.pop(context);
                  }
                },
                icon: Icon(
                  FontAwesomeIcons.floppyDisk, size: 25,
                )),
            SizedBox(width: 20,)
          ],
          centerTitle: true),
      body: SafeArea(
        child: ListView(
          children: [
            MyTextField(
                onChanged: (value) => model.namePill = value,
                hintTextField: 'Название лекарства',
                controller: namePillController),
            MyTextField(
              onChanged: (value) => model.descriptionPill = value,
              hintTextField: 'Описание лекарства',
              controller: descriptionPillController,
              maxLine: 3,
            ),
            SizedBox(
              height: 15,
            ),
            MyButton(
                myText: Text('Изменить фото лекарства'),
                onPress: () {
                  model.myShowAdaptiveActionSheet(context);
                }),
            SizedBox(
              height: 10,
            ),
            model.tumbler == false
                ?  MyAvatarPhoto(photo:Image.network(course.photoPill, fit: BoxFit.cover)):
                   MyAvatarPhoto(photo:Image.file(File(model.photoPill), fit: BoxFit.cover)),
            SizedBox(
              height: 10,
            ),
            MyButton(
                myText: Text('Добавить время приема лекарств'),
                onPress: () {
                  model.addTime(context);
                }),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 300,
              child: ListView.builder(
                  itemCount: model.timeOfReceipt.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        elevation: 4.0,
                        child: Column(
                          children: [
                            ListTile(
                                leading:Icon(FontAwesomeIcons.clock),
                                title: Text(model.timeOfReceipt[index].substring(10,15)),
                                trailing: IconButton(
                                  onPressed: () {
                                    model.delTime(index);
                                  },
                                  icon: Icon(FontAwesomeIcons.trash, color: Colors.red,),)
                            ),
                          ],
                        ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

