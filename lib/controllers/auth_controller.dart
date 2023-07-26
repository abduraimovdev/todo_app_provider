import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todo_app_provider/core/service_locator.dart';
import 'package:todo_app_provider/models/user/user.dart';
import 'package:todo_app_provider/repositories/user_repository.dart';
import 'package:todo_app_provider/screens/home_screen.dart';
import 'package:todo_app_provider/screens/splash_screen.dart';
import 'package:todo_app_provider/services/log_service.dart';

class AuthController extends ChangeNotifier {
  UserRepository repository;

  AuthController({required this.repository});

  // Variable
  static String? userId;

  // SignUp
  TextEditingController inNameController = TextEditingController();
  TextEditingController inPasswordController = TextEditingController();
  TextEditingController upNameController = TextEditingController();
  TextEditingController upPasswordController = TextEditingController();
  bool signInOrUp = false;

  // Methods

  void switchChange(bool value) {
    signInOrUp = value;
    notifyListeners();
  }

  void signUp(BuildContext context) async {
    try {
      User? user = await repository.authUser(
        User(
          id: "",
          createdAt: DateTime.now().toString(),
          name: upNameController.value.text.trim(),
          avatar: "",
          password: upPasswordController.value.text.trim(),
          todos: [],
          sync: '',
        ),
      );
      userId = user?.id;
      await locator
          .get<FlutterSecureStorage>()
          .write(key: "userId", value: user?.id);

      if (context.mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
      }
    } catch (e) {
      LogService.e(e.toString());
    }
  }

  void signIn(BuildContext context) async {
    try {
      User? user = await repository.loginUser(
        inNameController.value.text.trim(),
        inPasswordController.value.text.trim(),
      );
      userId = user?.id;
      await locator
          .get<FlutterSecureStorage>()
          .write(key: "userId", value: user?.id);
      if (context.mounted) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ));
      }
    } catch (e) {
      LogService.e(e.toString());
    }
  }

  void logOut(BuildContext context) async {
    userId = null;
    await locator.get<FlutterSecureStorage>().write(key: "userId", value: null);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ));
  }

  @override
  void dispose() {
    inNameController.dispose();
    inPasswordController.dispose();
    upNameController.dispose();
    upPasswordController.dispose();
    super.dispose();
  }
}
