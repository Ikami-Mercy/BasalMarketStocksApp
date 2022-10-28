import 'package:flutter/material.dart';

import '../widgets/no_internet_widget.dart';

class ErrorStatePage extends StatelessWidget {
  final String message;
  final bool isConnectedToInternet;

  const ErrorStatePage(
      {Key? key, required this.message, required this.isConnectedToInternet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center ,
          children: [
            NoInternetWidget(connectedToInternet: isConnectedToInternet),
            Center(
              child: Text(
                message,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),

    );
  }
}
