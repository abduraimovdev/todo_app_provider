import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todo_app_provider/controllers/auth_controller.dart';
import 'package:todo_app_provider/core/service_locator.dart';
import 'package:todo_app_provider/screens/auth_screen.dart';
import 'package:todo_app_provider/screens/home_screen.dart';

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

  void changer() async {
    Future.delayed(const Duration(seconds: 1)).whenComplete(
      () => setState(() {
        opacity = 1;
        size = 70;
      }),
    );
  }

  void goto(BuildContext context) {
    Future.delayed(const Duration(seconds: 1)).whenComplete(
      () async {
        String? id =
            await locator.get<FlutterSecureStorage>().read(key: "userId");
        if (id != null) {
          AuthController.userId = id;
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          }
        } else {
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AuthScreen(),
              ),
            );
          }
        }
      },
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
          onEnd: () => goto(context),
        ),
      ),
    );
  }
}
