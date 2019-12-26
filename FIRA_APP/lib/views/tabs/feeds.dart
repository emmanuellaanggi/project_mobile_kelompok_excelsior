import 'package:fira/models/user.dart';
import 'package:flutter/material.dart';
import 'package:fira/models/feed.dart';
import 'package:fira/widgets/feed_card1.dart';
import 'package:fira/widgets/feed_card2.dart';
import 'package:fira/widgets/feed_card3.dart';
import 'package:fira/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FeedsPage extends StatelessWidget {

  Future<String> getUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String users = user.uid;
    final Firestore _firestore = Firestore.instance;

    var snapshots = _firestore.collection('users').document(users).collection('name');

    print(snapshots);

    return users;
  }


  @override

  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getUser(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        final pageTitle = Padding(
          padding: EdgeInsets.only(top: 1.0, bottom: 30.0),
          child: Text(
            'Selamat Datang ${snapshot.data}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
        );;

        List<Widget> children;

        if (snapshot.hasData) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                color: Colors.grey.withOpacity(0.1),
                padding: EdgeInsets.only(top: 40.0),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 0.0, left: 30.0, right: 30.0, bottom: 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          pageTitle,
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
      } else {
          children = <Widget>[
            SizedBox(
              child: CircularProgressIndicator(),
              width: 60,
              height: 60,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting result...'),
            )
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }
}
