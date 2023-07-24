import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/controllers/todo_controller.dart';
import 'package:todo_app_provider/core/app_root.dart';
import 'package:todo_app_provider/models/todo/todo.dart';
import 'package:todo_app_provider/screens/detail_screen.dart';

class ItemCard extends StatelessWidget {
  final Todo todo;
  const ItemCard({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          context.read<TodoController>().status = Status.read;
          AppRoutes.goDetailFromHome(context: context, key: key, id: todo.id.toString());
        },
        title: Text(todo.title),
        subtitle: Text(todo.description),
        trailing: Consumer<TodoController>(
          builder: (context, model, __) {
            return Checkbox(
              value: todo.isComplete,
              onChanged: (value) => model.completeUpdate(todo.id, value!),
            );
          }
        ),
      ),
    );
  }
}