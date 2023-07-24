import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/controllers/connectivity_controller.dart';
import 'package:todo_app_provider/controllers/todo_controller.dart';

class DetailScreen extends StatelessWidget {
  final String? id;
  const DetailScreen({Key? key, this.id}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    context.read<TodoController>().checkDetail(id);
    return Consumer2<TodoController, ConnectivityController>(
      builder: (context, model, connectivity, _) {
        connectivity.connectionContext = context;
        return Scaffold(
          appBar: AppBar(
            title: Text(model.status.name.substring(0, 1).toUpperCase() + model.status.name.substring(1)),
            actions: [
              if(id != null) IconButton(onPressed: () {
                model.deleteTodo(id!, context);
              }, icon: const Icon(Icons.delete),),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                TextField(
                  controller: model.controllerTitle,
                  decoration: const InputDecoration(
                    hintText: "Title",
                  ),
                  readOnly: model.status == Status.read,
                ),
                const SizedBox(height: 10),

                Expanded(
                  child: TextField(
                    controller: model.controllerDescription,
                    maxLines: 29,
                    decoration: const InputDecoration(
                      hintText: "Description",
                    ),
                    readOnly: model.status == Status.read,
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => model.pressFAB(id, context),
            child: Icon(model.status == Status.read ? Icons.edit : Icons.done),
          ),
        );
      }
    );
  }
}

enum Status {
  read,
  create,
  edit,
}