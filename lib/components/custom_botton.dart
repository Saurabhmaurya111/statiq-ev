import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   final void Function()? onTap;
  const CustomButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.blue[900],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            'Sign In',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
