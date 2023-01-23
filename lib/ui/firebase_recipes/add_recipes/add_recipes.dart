import 'package:doctor/my_widgets/my_avatar_photo.dart';
import 'package:doctor/my_widgets/my_button.dart';
import 'package:doctor/my_widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../const/const.dart';
import 'add_recipes_model.dart';
import 'dart:io';
import 'package:internet_connection_checker/internet_connection_checker.dart';


class AddRecipesProviderWidget extends StatelessWidget {
  const AddRecipesProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AddRecipesModel(), child: AddRecipes());
  }
}

class AddRecipes extends StatelessWidget {
  AddRecipes({Key? key}) : super(key: key);
  final TextEditingController namePillController = TextEditingController();
  final TextEditingController descriptionPillController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final model = context.watch<AddRecipesModel>();
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Лекарь',
            style: MyTextStyle.textStyle25,
          ),
          actions: [
            IconButton(
               onPressed: () async {
                 bool result = await InternetConnectionChecker().hasConnection;
                 if(result != true) {
                   Fluttertoast.showToast(
                       msg: 'Нет интернета',
                       toastLength: Toast.LENGTH_SHORT,
                       gravity: ToastGravity.CENTER,
                       timeInSecForIosWeb: 1,
                       backgroundColor: Colors.red,
                       textColor: Colors.white,
                       fontSize: 16.0);
                   return;
                 }
                 showDialog(
                     barrierDismissible: false,
                     context: context,
                     builder: (BuildContext context) {
                       return Center(child: CircularProgressIndicator(),);
                     });

                String error = await model.compliteCourseAndToFirebase();

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
                myText: model.tumbler != true ? Text('Добавить фото лекарства'): Text('Изменить фото лекарства'),
                onPress: () {
                  model.myShowAdaptiveActionSheet(context);
                }),
            SizedBox(
              height: 10,
            ),
            model.tumbler == true
                ?  MyAvatarPhoto(photo:Image.file(File(model.photoPill), fit: BoxFit.cover))
            : Container(),
            SizedBox(
              height: 10,
            ),
            MyButton(
                myText: Text('Добавить время приема лекарств'),
                onPress: () {
                  model.addTime(context);
                  FocusManager.instance.primaryFocus?.unfocus();
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

