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
    case landingViewRoute:
      return MaterialPageRoute(builder: (context) => LandingPage());
    case homeViewRoute:
      return MaterialPageRoute(builder: (context) => HomePage());
    case loginViewRoute:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case registerViewRoute:
      return MaterialPageRoute(builder: (context) => RegisterPage());
    case resetPasswordViewRoute:
      return MaterialPageRoute(builder: (context) => ResetPasswordPage());
    case chatDetailsViewRoute:
      return MaterialPageRoute(builder: (context) => ChatDetailsPage(userId: settings.arguments));
    case userDetailsViewRoute:
      return MaterialPageRoute(builder: (context) => UserDetailsPage(userId: settings.arguments));
    case reportViewRoute:
      return MaterialPageRoute(builder: (context) => ReportPage());
      break;
    default:
      return MaterialPageRoute(builder: (context) => LandingPage());
  }
}
