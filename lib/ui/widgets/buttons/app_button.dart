import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.title, this.child, this.onPressed, this.titleStyle});

  final String title;
  final Widget? child;
  final VoidCallback? onPressed;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        title
      ),
    );
  }
}
