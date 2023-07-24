import 'package:flutter/material.dart';
import 'package:todo_app_provider/core/app_root.dart';
import 'package:todo_app_provider/models/todo/todo.dart';
import 'package:todo_app_provider/repositories/todo_repository.dart';
import 'package:todo_app_provider/screens/detail_screen.dart';

/// State Management:
/// page based
/// feature based
class TodoController with ChangeNotifier {
  final TodoRepository repository;

  TodoController({required this.repository}){
    checkConnection();
  }

  bool isLoading = false;
  List<Todo> todos = [];

  final TextEditingController controllerTitle = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();
  Status status = Status.read;

  void checkConnection() {

  }
  void fetchTodos() async {
    isLoading = true;
    notifyListeners();

    todos = await repository.getTodos();

    isLoading = false;
    notifyListeners();
  }

  void checkDetail(String? id) async {
    if (id != null) {
      fetchTodo(id);
    } else {
      status = Status.create;
    }
  }

  Future<void> fetchTodo(String id) async {
    Todo todo = await repository.getTodo(id);
    controllerTitle.text = todo.title;
    controllerDescription.text = todo.description;

    notifyListeners();
  }

  /// TODO: connecting with screen
  Future<bool> createTodo() async {
    isLoading = true;
    notifyListeners();

    Todo todo = await repository.createTodo(
      Todo(
        createdAt: DateTime.now().toString(),
        updatedAt: DateTime.now().toString(),
        isComplete: false,
        title: controllerTitle.text,
        description: controllerDescription.text,
        id: "00",
        userId: '1',
      ),
    );
    todos.add(todo);

    isLoading = false;
    notifyListeners();
    return true;
  }

  Future<void> deleteTodo(String id, BuildContext context) async {
    final result = await repository.deleteTodo(id);
    if (result) {
      /// TODO: success message
      todos.removeWhere((element) => element.id == id);
      notifyListeners();
      if (context.mounted) {
        AppRoutes.close(context);
      }
    } else {
      /// TODO: error message: "Something error" or "Check connection"
    }
  }

  void pressFAB(String? id, BuildContext context) async {
    if (status == Status.read) {
      status = Status.edit;
      notifyListeners();
    } else {
      bool result;
      if (status == Status.edit) {
        result = await editTodo(id!);
      } else {
        result = await createTodo();
      }
      if (context.mounted && result) AppRoutes.close(context);
    }
  }

  Future<bool> editTodo(String id) async {
    isLoading = true;
    notifyListeners();

    Todo todo = todos.firstWhere((element) => element.id == id);
    todo = await repository.updateTodo(
        id,
        Todo(
          createdAt: todo.createdAt,
          updatedAt: DateTime.now().toString(),
          isComplete: todo.isComplete,
          title: controllerTitle.text,
          description: controllerDescription.text,
          id: todo.id,
          userId: '1',
        ));
    todos.removeWhere((element) => element.id == id);
    todos.add(todo);

    isLoading = false;
    notifyListeners();
    return true;
  }

  void completeUpdate(String id, bool currentComplete) async {
    await repository.completeTodo(id, currentComplete);
    fetchTodos();
  }


}
