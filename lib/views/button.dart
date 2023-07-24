import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final void Function()? onPress;

  const Button({
    super.key,
    required this.text,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size(MediaQuery.sizeOf(context).width * 0.6,
            MediaQuery.sizeOf(context).height * 0.06),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPress,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
