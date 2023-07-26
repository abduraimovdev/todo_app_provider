import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app_provider/services/db_service.dart';
import 'package:todo_app_provider/services/hive_service.dart';

Future<void> initializeApp() async {

  SqlDatabase.init();
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

}