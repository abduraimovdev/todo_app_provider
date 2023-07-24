import 'package:flutter/material.dart';
import 'package:todo_app_provider/core/init.dart';
import 'package:todo_app_provider/core/service_locator.dart';
import 'app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await initializeApp();
  setupLocator();
  runApp(const TodoApp());
}