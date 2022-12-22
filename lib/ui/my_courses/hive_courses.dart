
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../api/timeofdate/timeofdate.dart';
import 'hive_courses_model.dart';

class CoursesProviderWidget extends StatelessWidget {
  const CoursesProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(value:CoursesModel(),
        child: const Courses());
  }
}

class Courses extends StatelessWidget {
  const Courses({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = context.watch <CoursesModel>();
    return ListView.builder(
        itemCount:model.courses.length,
        itemBuilder: (BuildContext context, int index) {
          return CardWidget(indexInList: index);
        });
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    required this.indexInList
  }) : super(key: key);
  final int indexInList;

  @override
  Widget build(BuildContext context) {
    final model = context.watch <CoursesModel>();
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[Text('Удалить Рецепт?')],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  child: const Text('Да',
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                  onPressed: () {
                    model.deleteCourse(indexInList);
                    Navigator.of(context).pop();
                  }),
              TextButton(
                child: const Text('Нет',
                    style: TextStyle(color: Colors.black, fontSize: 15)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Card(
      elevation: 8,
      shadowColor: Colors.black,
      child: ListTile(
          tileColor: Colors.white,
          onTap: () {},
          leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.file(File(model.courses[indexInList].photoPill)),
          ),
          title: Text(model.courses[indexInList].namePill),
          subtitle: Text(
              TimeOfDateConvert.listInString(model.courses[indexInList].timeOfReceipt)),
          trailing: IconButton(
              onPressed: () {
                _showMyDialog();
              },
              icon: const Icon(
                FontAwesomeIcons.bucket,
                color: Colors.deepOrange,
              ))),
    );
  }
}