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
                    padding: const EdgeInsets.only(top: 40, left: 20.0, right: 20.0),
                    child: Material(
                        elevation: 10.0,
                        borderRadius: BorderRadius.circular(8.0),
                        shadowColor: Colors.white,
                        child: Container(
                            height: 130.0,
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
      padding: EdgeInsets.only(top:20.0, right: 20.0, left: 20.0, bottom: 30.0),
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
              _buildIconTile(context, LineIcons.money, Colors.red, 'My Wallet', landingViewRoute),
              hr,
              _buildIconTile(context, LineIcons.diamond, Colors.blue, 'VIP Center', landingViewRoute),
              hr,
              _buildIconTile(context,
                  LineIcons.user_plus, Colors.orangeAccent, 'Find Friends', landingViewRoute),
              hr,
              _buildIconTile(context,LineIcons.user_times, Colors.black, 'Blacklist', landingViewRoute),
              hr,
              _buildIconTile(context,
                  LineIcons.cogs, Colors.grey.withOpacity(0.6), 'Settings', landingViewRoute),
            ],
          ),
        ),
      ),
    );

    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
          child:
              Container(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(color: Color(0xFFfbab66)),
                            padding: EdgeInsets.only(
                              left: deviceWidth,
                              bottom: deviceHeight*1.36,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(gradient: primaryGradient),
                            padding: EdgeInsets.only(
                              left: deviceWidth,
                              bottom: deviceHeight*0.86,
                            ),
                          ),
                          Positioned(top: 30, right: 0, left: 0, child: _buildUserInfo(context)),
                          Positioned(top: 210, right: 0, left: 0, child: secondCard),
                          Positioned(top: 440, right: 0, left: 0, child: thirdCard),
                        ],
                      ),
                    ],
                  )
              ),


        )
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
