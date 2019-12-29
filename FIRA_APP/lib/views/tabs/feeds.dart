import 'package:fira/models/user.dart';
import 'package:flutter/material.dart';
import 'package:fira/models/feed.dart';
import 'package:fira/widgets/feed_card1.dart';
import 'package:fira/widgets/feed_card2.dart';
import 'package:fira/widgets/feed_card3.dart';
import 'package:fira/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

class FeedsPage extends StatelessWidget {

  Future<String> getUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String users = user.uid;

    return users;
  }

  String test(String t) {
    return t;
  }
  _launchCaller() async {
    const url = "tel:1234567";
    if (await urlLauncher.canLaunch(url)) {
      await urlLauncher.launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) =>
      new Scaffold(
        body: new Center(
          child: new FlatButton(
              onPressed: () => _launchCaller(),
              child: new Text("BELOM")),
        ),
      );
}