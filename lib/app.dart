import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/controllers/auth_controller.dart';
import 'package:todo_app_provider/controllers/connectivity_controller.dart';
import 'package:todo_app_provider/controllers/todo_controller.dart';
import 'package:todo_app_provider/core/service_locator.dart';
import 'package:todo_app_provider/screens/splash_screen.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthController>(
          create: (context) => locator<AuthController>(),
        ),
        ChangeNotifierProvider<TodoController>(
          create: (context) => locator<TodoController>()..fetchTodos(),
        ),
        ChangeNotifierProvider<ConnectivityController>(
          create: (context) => locator<ConnectivityController>(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: ThemeMode.dark,
        title: "Todo App",
        home: const SplashScreen(),
      ),
    );
  }
}
