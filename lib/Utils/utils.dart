import 'package:flutter/material.dart';

class Utils{

  // Shows a snack bar message.
  static void showSnackBar(BuildContext context, String message,Color backgroundColor ,
      {Duration duration = const Duration(seconds: 2) }) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 16.0),
      ),
      duration: duration,
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}