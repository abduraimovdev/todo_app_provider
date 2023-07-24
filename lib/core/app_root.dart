import 'package:flutter/material.dart';
import 'package:todo_app_provider/screens/detail_screen.dart';

sealed class AppRoutes {
  static void goDetailFromHome(
      {required BuildContext context, String? id, Key? key}) {


    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DetailScreen(key: key, id: id),
      ),
    );
  }

  static void close(BuildContext context) {
    Navigator.of(context).pop();
  }
}
