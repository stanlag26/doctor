import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/my_widgets/my_avatar.dart';
import 'package:doctor/ui/firebase_recipes/recipes/recipes_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../api/firebase_api/firebase_api.dart';
import '../../../api/timeofdate/timeofdate.dart';
import '../../../entity/course.dart';
import '../add_recipes/add_recipes.dart';
import '../one_recipe/one_recipe.dart';

class RecipesProviderWidget extends StatelessWidget {
  const RecipesProviderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => RecipesModel(), child: const Recipes());
  }
}

class Recipes extends StatelessWidget {
  const Recipes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Course')
            .where("idUser", isEqualTo: "HgpJgQ9FppebnBmiuvNIbgKgiMG3")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: Text('Нет данных'));
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic>? json = snapshot.data?.docs[index].data();
              Course course = Course.fromJson(json!);
              course.idDoc = snapshot.data!.docs[index].id;
              return CardWidget(course: course);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
        onPressed: () {
          Navigator.pushNamed(context, '/recides/add');
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    required this.course,
  }) : super(key: key);
  final Course course;
  @override
  Widget build(BuildContext context) {
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
                    FireBaseApi.delCourse(course);
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
          onTap: () {
            Navigator.pushNamed(context, '/recides/one', arguments: course);
          },
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              course.photoPill,
            ),
          ),
          title: Text(course.namePill),
          subtitle: Text(TimeOfDateConvert.listInString(course.timeOfReceipt)),
          trailing: IconButton(
              onPressed: () {
                _showMyDialog();
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.deepOrange,
              ))),
    );
  }
}
