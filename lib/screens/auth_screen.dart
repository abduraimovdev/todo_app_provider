import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_provider/controllers/auth_controller.dart';
import 'package:todo_app_provider/controllers/connectivity_controller.dart';
import 'package:todo_app_provider/views/button.dart';
import 'package:todo_app_provider/views/input.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer2<AuthController, ConnectivityController>(
          builder: (context, controller, connectivity, __) {
            connectivity.connectionContext = context;
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Switch(
                  value: controller.signInOrUp,
                  inactiveThumbColor: Theme.of(context).scaffoldBackgroundColor,
                  inactiveTrackColor: Theme.of(context).splashColor,
                  activeColor: Theme.of(context).scaffoldBackgroundColor,
                  activeTrackColor: Theme.of(context).splashColor,
                  onChanged: controller.switchChange,
                ),
                const SizedBox(height: 10),
                Text(
                  controller.signInOrUp ? "Sign In" : "Sign Up",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 40),
                AnimatedRotation(
                  duration: const Duration(milliseconds: 800),
                  turns: controller.signInOrUp ? 1 : 4,
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    height: MediaQuery.sizeOf(context).width * 0.9,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).splashColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: controller.signInOrUp
                        ?
                        // Sign In Screen
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Input(
                                label: "Name",
                                controller: controller.inNameController,
                              ),
                              Input(
                                label: "Password",
                                controller: controller.inPasswordController,
                              ),
                              Button(
                                text: "Sign In",
                                onPress: () => controller.signIn(context),
                              ),
                            ],
                          )
                        :
                        // Sign Up Screen
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Input(
                                label: "Name",
                                controller: controller.upNameController,
                              ),
                              Input(
                                label: "Password",
                                controller: controller.upPasswordController,
                              ),
                              Button(
                                text: "Sign Up",
                                onPress: () => controller.signUp(context),
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 100),
              ],
            );
          },
        ),
      ),
    );
  }
}
