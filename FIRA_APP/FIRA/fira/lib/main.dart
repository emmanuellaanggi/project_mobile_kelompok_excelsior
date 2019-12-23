import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fira/app.dart';
import 'package:fira/utils/colors.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: primaryDark
  ));
  runApp(App());
}