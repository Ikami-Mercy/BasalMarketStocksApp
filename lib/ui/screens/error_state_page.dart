import 'package:flutter/material.dart';

class ErrorStatePage extends StatelessWidget {
  final String message;
  const ErrorStatePage({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
