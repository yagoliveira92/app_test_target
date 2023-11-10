import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton(
      {required this.isLoading, required this.onPressed, super.key});
  final VoidCallback onPressed;
  final bool isLoading;
  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: 55.0,
            vertical: 15.0,
          ),
          backgroundColor: const Color(0xFF44BD6E),
        ),
        onPressed: onPressed,
        child: isLoading
            ? const SizedBox(
                height: 25.0,
                width: 25.0,
                child: CircularProgressIndicator(color: Colors.white),
              )
            : const Text(
                'Entrar',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
      );
}
