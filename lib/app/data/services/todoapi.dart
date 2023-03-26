import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elredtodo/app/data/models/todo_model.dart';
import 'package:elredtodo/app/data/services/apiconstants.dart';
import 'package:flutter/material.dart';

class TodoApi {
  static Future<List<Todo>?> getTodoList(String userId) async {
    List<Todo>? todoList;
    try {
      todoList = [];
      List<QueryDocumentSnapshot<Map<String, dynamic>>>? resData;
      await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(userId)
          .collection(todos)
          .get()
          .then((value) => resData = value.docs);

      if (resData != null) {
        resData?.forEach((value) => todoList?.add(Todo.fromMap(value.data())));
      }

      return todoList;
    } catch (e) {
      debugPrint(e.toString());
    }
    return todoList;
  }

  static addTodo(String userId, Map<String, dynamic> data) async {
    try {
      String docId = DateTime.now().millisecondsSinceEpoch.toString();
      data['id'] = docId;
      await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(userId)
          .collection(todos)
          .doc(docId)
          .set(data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static editTodo(String userId, Map<String, dynamic> data) async {
    try {
      final CollectionReference userCollection =
          FirebaseFirestore.instance.collection('userdata');

      final DocumentReference userDoc =
          userCollection.doc(userId).collection(todos).doc(data['id']);

      await userDoc.update(
        {
          'id': data['id'],
          'title': data['title'],
          'description': data['description'],
          'type': data['type'],
          'date': data['date'],
          'completed': false
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static deleteTodo(String userId, String id) async {
    try {
      var todoList = [];
      await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(userId)
          .collection(todos)
          .doc(id)
          .delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static markDoneTodo(String userId, Map<String, dynamic> data) async {
    try {
      final CollectionReference userCollection =
          FirebaseFirestore.instance.collection('userdata');

      final DocumentReference userDoc =
          userCollection.doc(userId).collection(todos).doc(data['id']);

      await userDoc.update(
        {'completed': data['completed']},
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
