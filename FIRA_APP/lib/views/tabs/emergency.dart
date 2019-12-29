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

class Emergency extends StatelessWidget {

  _launchCaller() async {
    const url = "tel:1234567";
    if (await urlLauncher.canLaunch(url)) {
      await urlLauncher.launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget Explanation() {
    return Text(
        "Untuk keadaan darurat yang \n berpotensi kebakaran besar",
        style: TextStyle(
          fontSize: 20.0,
          color: Colors.red,
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                padding: EdgeInsets.only(top: 200.0),
                child: Column(
                    children: <Widget>[
                      Explanation(),
                      new RaisedButton(
                          onPressed: () => _launchCaller(),
                          child: new Text("Klik Untuk Menelpon Unit Darurat")),
    ]
    )
    )
    )
    );
  }
}