import 'package:elredtodo/app/data/models/todo_model.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  List<Todo>? todoList = [Todo(title: "TODO 1", completed: false)];

  List<Todo>? get getInboxTodo =>
      todoList?.where((e) => e.completed == false).toList();

  List<Todo>? get getCompleteTodo =>
      todoList?.where((e) => e.completed == true).toList();

  fetchTodoData() {}
}
