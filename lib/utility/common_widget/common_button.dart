import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String name;
  final VoidCallback onPressed;
  const CommonButton({super.key, required this.name, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 26),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: Colors.blueAccent.withOpacity(0.8),
        foregroundColor: Colors.white,
        elevation: 5,
      ),
      child: Text(
        name.toString(),
      ),
    );
  }
}
