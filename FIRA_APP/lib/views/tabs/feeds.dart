import 'package:fira/models/feature.dart';
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
import 'package:fira/utils/utils.dart';

class FeedsPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    final featureHeading = Text(
      "Fitur",
      style: TextStyle(
        color: Colors.black.withOpacity(0.6),
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
      ),
    );

    final listOfFeature = Container(
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: features.map((feature) => _buildUserCard(feature, context)).toList(),
      ),
    );

    final onlineFeature = Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          featureHeading,
          SizedBox(
            height: 10.0,
          ),
          listOfFeature
        ],
      ),
    );


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
                    padding: EdgeInsets.only(top: 120.0, left: 30.0, right: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        onlineFeature,
                      ],
                    ),
                  ),
                  Positioned( top: 30, child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Container(
                      height: 100.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AvailableImages.homePage,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  ),

                ]),
            ],
          ),
        ),
      ),
    );

  }
}

Widget _buildUserCard(Feature feature, BuildContext context) {
  final firstName = feature.name.split(" ")[0];

  return Column(
    children: <Widget>[
      InkWell(
        onTap: () => {},
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 8.0),
              height: 70.0,
              width: 70.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(feature.photo),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
      Text(
        firstName,
        style: TextStyle(fontWeight: FontWeight.w600),
      )
    ],
  );
}