import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


/// Class for App styles & themes
class Styles{
  /// App Theme style

  static SystemUiOverlayStyle overlayStyle() {
    return const SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.light,
    );
  }

  static void setStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(
      overlayStyle(),
    );
  }
}