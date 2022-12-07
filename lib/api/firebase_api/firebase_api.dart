
//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class FireBaseApi {
//
//   static Future <String> createToDo (Todo todo) async {
//     final docToDo = FirebaseFirestore.instance.collection('todo').doc();
//     todo.idDo = docToDo.id;
//     await  docToDo.set(todo.toJson());
//     return docToDo.id;
//
//   }
//
// }