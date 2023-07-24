import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app_provider/services/hive_service.dart';

Future<void> initializeApp() async {
  await const HiveService(title: Boxes.userInfo).init();
  await const HiveService(title: Boxes.userInfo).createBox<String?>(title: Boxes.userInfo);

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

}