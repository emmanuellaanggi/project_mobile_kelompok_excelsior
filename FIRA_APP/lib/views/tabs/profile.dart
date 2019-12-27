import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fira/models/user.dart';
import 'package:fira/utils/colors.dart';
import 'package:line_icons/line_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class ProfilePage extends StatelessWidget {
  final databaseReference = Firestore.instance;
  final User user = users[0];

  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            document['name'],
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            document['phone'],
            style: TextStyle(
              color: Colors.grey.withOpacity(0.6),
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context) {
    final hr = Divider();
    final userStats = Positioned(
      bottom: 10.0,
      left: 40.0,
      right: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildUserStats('VISITORS', '2305'),
          _buildUserStats('LIKED', '276'),
          _buildUserStats('MATCHED', '51'),
        ],
      ),
    );

    final userImage = Container(
      height: 70.0,
      width: 70.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(user.photo),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
      ),
    );

    return new StreamBuilder(
        stream: Firestore.instance.collection('users').snapshots(),
        //print an integer every 2secs, 10 times
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading..");
          }
          return Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(8.0),
                  shadowColor: Colors.white,
                  child: Container(
                      height: 200.0,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        color: Colors.white,
                      ),
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, bottom: 20.0),
                          child: Row(
                              children: <Widget>[
                                userImage,
                                SizedBox(width: 10.0),
                                _buildList(context, snapshot.data.documents[0])
                              ]
                          )
                      )
                  )
              )
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final hr = Divider();
    final userNameLocation = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Test',
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            user.location,
            style: TextStyle(
              color: Colors.grey.withOpacity(0.6),
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );


    final secondCard = Padding(
      padding: EdgeInsets.only(right: 20.0, left: 20.0, bottom: 30.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(8.0),
        shadowColor: Colors.white,
        child: Container(
          height: 200.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: <Widget>[
              _buildIconTile(Icons.favorite, Colors.red, 'Likes'),
              hr,
              _buildIconTile(LineIcons.eye, Colors.green, 'Visitors'),
              hr,
              _buildIconTile(LineIcons.users, Colors.purpleAccent, 'Groups'),
            ],
          ),
        ),
      ),
    );

    final thirdCard = Padding(
      padding: EdgeInsets.only(right: 20.0, left: 20.0, bottom: 30.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(8.0),
        shadowColor: Colors.white,
        child: Container(
          height: 350.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: <Widget>[
              _buildIconTile(LineIcons.money, Colors.red, 'My Wallet'),
              hr,
              _buildIconTile(LineIcons.diamond, Colors.blue, 'VIP Center'),
              hr,
              _buildIconTile(
                  LineIcons.user_plus, Colors.orangeAccent, 'Find Friends'),
              hr,
              _buildIconTile(LineIcons.user_times, Colors.black, 'Blacklist'),
              hr,
              _buildIconTile(
                  LineIcons.cogs, Colors.grey.withOpacity(0.6), 'Settings'),
            ],
          ),
        ),
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 350.0,
                      ),
                      Container(
                        height: 250.0,
                        decoration: BoxDecoration(gradient: primaryGradient),
                      ),
                      Positioned(top: 100, right: 0, left: 0, child: _buildUserInfo(context))
                    ],
                  ),
                  secondCard, thirdCard
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserStats(String name, String value) {
    return Column(
      children: <Widget>[
        Text(
          name,
          style: TextStyle(
            color: Colors.grey.withOpacity(0.6),
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w900,
            fontSize: 20.0,
          ),
        ),
      ],
    );
  }

  Widget _buildIconTile(IconData icon, Color color, String title) {
    return ListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold),),
      leading: Container(
        height: 30.0,
        width: 30.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
      trailing: Icon(LineIcons.chevron_circle_right),
    );
  }
}
