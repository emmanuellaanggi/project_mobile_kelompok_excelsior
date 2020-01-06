import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fira/utils/colors.dart';
import 'package:fira/utils/utils.dart';
import 'package:fira/views/home.dart';
import 'package:fira/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Medium extends StatefulWidget {
  Medium({this.authHandler, this.loginCallback});

  final Auth authHandler;
  final VoidCallback loginCallback;

  @override
  _Medium createState() => _Medium();
}

class _Medium extends State<Medium> {

  final hr = Divider();
  var authHandler = new Auth();

  @override
  Widget build(BuildContext context) {

    final appBar = Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          )
        ],
      ),
    );

    final pageTitle = Center(child: Container(
      child: Text(
        "Selamat Datang!\n Ayo Cegah Api Bersama-sama!",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 25.0,
        ),
      ),
    ));


    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    FutureOr _showDialog() async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Halo!"),
            content: new Text("Selamat Datang"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Lanjut"),
                onPressed: () {
                  authHandler.getUser()
                      .then((currentUser) => Firestore.instance
                      .collection("users")
                      .document(currentUser.uid)
                      .collection("laporan")
                      .document("0")
                      .setData({
                    "id_laporan" : "0"
                  }));
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => new HomePage()));
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFfbab66),
          padding: EdgeInsets.only(top: 30.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                  children: <Widget>[
                    Container(
                        decoration: BoxDecoration(gradient: primaryGradient),
                        padding: EdgeInsets.only(
                          left: deviceWidth,
                          bottom: deviceHeight,
                        )),
                    Container(
                      padding: EdgeInsets.only(top: 130.0, left: 20.0, right: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 150.0,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AvailableImages.appLogo,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Divider(),

                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Container(
                          margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
                          height: 60.0,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.0),
                            border: Border.all(color: Colors.white),
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(7.0),
                            color: primaryColor,
                            elevation: 10.0,
                            shadowColor: Colors.white70,
                            child: MaterialButton(
                              onPressed:() {
                                authHandler.getUser()
                                    .then((currentUser) => Firestore.instance
                                    .collection("users")
                                    .document(currentUser.uid)
                                    .collection("laporan")
                                    .document("0")
                                    .setData({
                                  "id_laporan" : "0"
                                }));
                                Navigator.push(context, new MaterialPageRoute(builder: (context) => new HomePage()));
                              },
                              child: Text(
                                'LANJUT',
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                        ],
                      ),
                    )
                  ])
            ],
          ),
        ),
      ),
    );
  }
}
