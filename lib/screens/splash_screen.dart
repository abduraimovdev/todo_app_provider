import 'package:flutter/material.dart';
import 'package:todo_app_provider/core/service_locator.dart';
import 'package:todo_app_provider/screens/auth_screen.dart';
import 'package:todo_app_provider/services/hive_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 0;
  double size = 20;
  bool isAuth = false;

  @override
  void initState() {
    changer();
    super.initState();
  }

  void changer() async{
    try {
      String? id = await locator.get<HiveService>().read("userId");
      if(id != null) {

      }
    }catch(e) {
      print(e);
    }
    Future.delayed(const Duration(seconds: 1)).whenComplete(
      () => setState(() {
        opacity = 1;
        size = 70;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedDefaultTextStyle(
          style: TextStyle(
            fontSize: size,
            color: Colors.white.withOpacity(opacity),
          ),
          duration: const Duration(seconds: 2),
          child: const Text("Todo App"),
          onEnd: () {
            Future.delayed(const Duration(seconds: 1)).whenComplete(
              () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthScreen(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
