import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/controllers/auth_controller.dart';
import 'package:todo_app_provider/controllers/connectivity_controller.dart';
import 'package:todo_app_provider/controllers/todo_controller.dart';
import 'package:todo_app_provider/core/app_root.dart';
import 'package:todo_app_provider/screens/detail_screen.dart';
import 'package:todo_app_provider/views/item_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: IconButton(
              onPressed: () => Provider.of<AuthController>(context, listen: false).logOut(context),
              icon: const Icon(Icons.logout),
            ),
          ),
        ],
        title: const Text("Todos"),
      ),
      body: Consumer2<TodoController, ConnectivityController>(
        builder: (context, controller, connectivity, child) {
          connectivity.connectionContext = context;
          return Stack(
            children: [
              ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: controller.todos.length,
                itemBuilder: (context, index) {
                  final todo = controller.todos[index];
                  return ItemCard(todo: todo);
                },
              ),
              if (controller.isLoading)
                const Center(
                  child: CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<TodoController>().controllerTitle.text = "";
          context.read<TodoController>().controllerDescription.text = "";
          context.read<TodoController>().status = Status.create;
          AppRoutes.goDetailFromHome(context: context, key: key);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
