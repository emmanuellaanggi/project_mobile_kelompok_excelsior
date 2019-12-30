import 'package:fira/_routing/routes.dart';
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
              fontWeight: FontWeight.w900,
              fontSize: 20.0
            ),
          ),
          Text(
            document['phone'],
            style: TextStyle(
              color: Colors.grey.withOpacity(0.6),
              fontWeight: FontWeight.w600,
                fontSize: 17.0
            ),
          ),
        ],
      ),
    );
  }

  Future<String> getUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    String users = user.uid;
    return users;
  }

  Widget _buildUserInfo(BuildContext context) {
    final hr = Divider();

    final userImage = Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
        color: Colors.red,
        image: DecorationImage(
          image: AssetImage(user.photo),
          fit: BoxFit.cover,
        ),
        shape: BoxShape.circle,
      ),
    );

    return FutureBuilder<String>(
        future: getUser(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          return new StreamBuilder(
              stream: Firestore.instance.collection('users').where(
                  'uid', isEqualTo: '${snapshot.data}').snapshots(),
              //print an integer every 2secs, 10 times
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading..");
                }
                return Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20.0, right: 20.0),
                    child: Material(
                        elevation: 10.0,
                        borderRadius: BorderRadius.circular(8.0),
                        shadowColor: Colors.white,
                        child: Container(
                            height: 90.0,
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
                                    top:10.0, left: 10.0, bottom: 10.0),
                                child: Row(
                                    children: <Widget>[
                                      userImage,
                                      SizedBox(width: 10.0),
                                      _buildList(context,
                                          snapshot.data.documents[0])
                                    ]
                                )
                            )
                        )
                    )
                );
              });
        });
  }


  @override
  Widget build(BuildContext context) {
    final hr = Divider();

    final secondCard = Padding(
      padding: EdgeInsets.only(top:10.0, right: 20.0, left: 20.0),
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
              _buildIconTile(context, Icons.settings, Colors.red, 'Pengaturan', homeViewRoute),
              hr,
              _buildIconTile(context, LineIcons.users, Colors.green, 'Grup', homeViewRoute),
              hr,
              _buildIconTile(context, LineIcons.sign_out, Colors.purpleAccent, 'Keluar', landingViewRoute),
            ],
          ),
        ),
      ),
    );

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
                    padding: EdgeInsets.only(top: 20, left: 1, right: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        _buildUserInfo(context),
                        secondCard,
                        secondCard

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


  Widget _buildIconTile(BuildContext context, IconData icon, Color color, String title, String route) {
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
      onTap: () => Navigator.pushNamed(context, route),

    );
  }
}
