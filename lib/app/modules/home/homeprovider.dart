import 'package:elredtodo/app/data/models/todo_model.dart';
import 'package:elredtodo/app/data/services/authservice.dart';
import 'package:elredtodo/app/data/services/todoapi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final AuthService authService;
  HomeProvider({required this.authService});
  List<Todo>? todoList;
  bool isLoading = true;

  List<Todo>? get getInboxTodo => todoList
      ?.where((e) => e.completed == false || e.completed == null)
      .toList();

  List<Todo>? get getCompleteTodo =>
      todoList?.where((e) => e.completed == true).toList();

  int get getPersonalCount =>
      todoList?.where((e) => e.type == 'personal').toList().length ?? 0;

  int get getBusinessCount =>
      todoList?.where((e) => e.type == 'business').toList().length ?? 0;

  double get getDonePercentage =>
      ((getCompleteTodo?.length ?? 0) / (todoList?.length ?? 0)) * 100;

  fetchTodoData({bool fromLogin = false}) async {
    if (fromLogin) {
      isLoading = true;
      notifyListeners();
    }
    if (await authService.currentUser != null) {
      todoList = await TodoApi.getTodoList(
          (await authService.currentUser as User).uid);
    }
    isLoading = false;
    notifyListeners();
  }

  removeTodoData() {
    todoList = [];
    notifyListeners();
  }

  markDone(String id, bool done) async {
    isLoading = true;
    notifyListeners();
    if (await authService.currentUser != null) {
      await TodoApi.markDoneTodo((await authService.currentUser as User).uid,
          {'id': id, 'completed': done});
    }
    fetchTodoData();
  }
}
