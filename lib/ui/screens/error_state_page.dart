import 'package:flutter/material.dart';

import '../widgets/no_internet_widget.dart';

class ErrorStatePage extends StatefulWidget {
  final String message;

  const ErrorStatePage({Key? key, required this.message}) : super(key: key);

  @override
  State<ErrorStatePage> createState() => _ErrorStatePageState();
}

class _ErrorStatePageState extends State<ErrorStatePage> {
  bool isConnectedToInternet = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const NoInternetWidget(),
          Center(
            child: Text(
              widget.message,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
