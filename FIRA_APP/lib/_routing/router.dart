import 'package:fira/views/read_article.dart';
import 'package:flutter/material.dart';
import 'package:fira/_routing/routes.dart';
import 'package:fira/views/chat_details.dart';
import 'package:fira/views/home.dart';
import 'package:fira/views/landing.dart';
import 'package:fira/views/login.dart';
import 'package:fira/views/register.dart';
import 'package:fira/views/reset_password.dart';
import 'package:fira/views/user_details.dart';
import 'package:fira/views/report.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {

    default:
      return MaterialPageRoute(builder: (context) => LandingPage());
  }
}
