import 'package:elredtodo/app/data/models/todo_model.dart';
import 'package:flutter/material.dart';

class TodoProvider extends ChangeNotifier {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController date = TextEditingController();
  String? selectedType;

  final Todo? todo;
  TodoProvider({this.todo}) {
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

  addTodo() {
    if (title.text.isNotEmpty ||
        date.text.isNotEmpty ||
        (selectedType?.isNotEmpty ?? false)) {
          
        }
  }
}
