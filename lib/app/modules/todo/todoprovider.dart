import 'package:elredtodo/app/core/utils/constant.dart';
import 'package:elredtodo/app/data/models/todo_model.dart';
import 'package:elredtodo/app/data/services/authservice.dart';
import 'package:elredtodo/app/data/services/todoapi.dart';
import 'package:elredtodo/app/modules/home/homeprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoProvider extends ChangeNotifier {
  final AuthService authService;
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController date = TextEditingController();
  String? selectedType;

  final Todo? todo;
  TodoProvider({this.todo, required this.authService}) {
    if (todo != null) {
      if (todo?.title != null) {
        title.text = todo?.title as String;
      }
      if (todo?.description != null) {
        description.text = todo?.description as String;
      }
      if (todo?.date != null) {
        date.text = todo?.date as String;
      }
      if (todo?.type != null) {
        selectedType = todo?.type;
      }
    }
  }

  List<String> dropDownItems = [
    "Personal",
    "Business",
    "Music",
    "Study",
    "Design",
    "Other"
  ];

  set setSelectedType(String? value) {
    selectedType = value;
    notifyListeners();
  }

  set setDateTime(String dates) => date.text = dates;

  addTodo() async {
    if (title.text.isNotEmpty &&
        date.text.isNotEmpty &&
        (selectedType?.isNotEmpty ?? false)) {
      if (await authService.currentUser != null) {
        Map<String, dynamic> todoData = {
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'title': title.text,
          'date': date.text,
          'type': selectedType,
          'completed': false
        };
        if (description.text.isNotEmpty) {
          todoData['description'] = description.text;
        }
        await TodoApi.addTodo(
            (await authService.currentUser as User).uid, todoData);
        Provider.of<HomeProvider>(navigatorKey.currentContext!, listen: false)
            .fetchTodoData();
        Navigator.pop(navigatorKey.currentContext!);
        ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
          const SnackBar(content: Text("Todo Added")),
        );
      }
    } else {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(content: Text("Fill Required field")),
      );
    }
  }

  editTodo() async {
    if (title.text.isNotEmpty &&
        date.text.isNotEmpty &&
        (selectedType?.isNotEmpty ?? false)) {
      if (await authService.currentUser != null) {
        Map<String, dynamic> todoData = {
          'id': todo?.id!,
          'title': title.text,
          'date': date.text,
          'type': selectedType,
        };
        if (description.text.isNotEmpty) {
          todoData['description'] = description.text;
        }
        await TodoApi.editTodo(
            (await authService.currentUser as User).uid, todoData);
        Provider.of<HomeProvider>(navigatorKey.currentContext!, listen: false)
            .fetchTodoData();
        Navigator.pop(navigatorKey.currentContext!);
        ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
          const SnackBar(content: Text("Todo Edited")),
        );
      }
    } else {
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(content: Text("Fill Required field")),
      );
    }
  }

  deleteTodo(String id) async {
    if (await authService.currentUser != null) {
      await TodoApi.deleteTodo((await authService.currentUser as User).uid, id);
    }
    Provider.of<HomeProvider>(navigatorKey.currentContext!, listen: false)
        .fetchTodoData();
    Navigator.pop(navigatorKey.currentContext!);
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      const SnackBar(content: Text("Deleted Todo")),
    );
  }
}
