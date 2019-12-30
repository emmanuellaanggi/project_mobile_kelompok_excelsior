import 'package:fira/models/user.dart';
import 'package:flutter/material.dart';
import 'package:fira/models/feed.dart';
import 'package:fira/widgets/feed_card1.dart';
import 'package:fira/widgets/feed_card2.dart';
import 'package:fira/widgets/feed_card3.dart';
import 'package:fira/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fira/utils/colors.dart';
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
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xFFfbab66) ,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 40.0),
          width: deviceWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(gradient: primaryGradient),
                    padding: EdgeInsets.only(
                      left: deviceWidth,
                      bottom: deviceHeight*0.77,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 170.0, left: 50.0, right: 35.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        
                        Text("BELOM")
                        
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );

  }

}