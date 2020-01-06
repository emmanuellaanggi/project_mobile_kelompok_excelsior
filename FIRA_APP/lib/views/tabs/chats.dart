import 'package:fira/views/home.dart';
import 'package:fira/views/report.dart';
import 'package:fira/views/tabs/emergency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fira/_routing/routes.dart';
import 'package:fira/models/chat.dart';
import 'package:fira/models/user.dart';
import 'package:fira/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatsPage extends StatelessWidget {

  Widget _buildList(BuildContext context, DocumentSnapshot document) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Laporan " + document['id_laporan'],
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            document['Laporan'],
            style: TextStyle(
                fontWeight: FontWeight.w200,
            ),
          ),
          Text(
            document['Lokasi'],
            style: TextStyle(
                color: Colors.grey.withOpacity(0.6),
                fontWeight: FontWeight.w600,

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

  Widget _buildUserInfo(BuildContext context, index) {
    return FutureBuilder<String>(
        future: getUser(), // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) {
            return Text("Belum ada laporan..");
          }
          return new StreamBuilder(
              stream: Firestore.instance.
              collection('users').
              where('uid', isEqualTo: '${snapshot.data}').
              snapshots(),
              builder: (context, snapshot) {
                DocumentSnapshot document = snapshot.data.documents[0];
                if (!snapshot.hasData) {
                  return Text("Belum ada laporan..");
                }
                return new StreamBuilder(
                    stream: Firestore.instance
                        .collection("users")
                        .document(document['uid'])
                        .collection("laporan")
                        .orderBy("id_laporan", descending: true).snapshots(),
                    builder: (context, snapshot2) {
                      DocumentSnapshot document2 = snapshot2.data.documents[index];
                      if (!snapshot.hasData) {
                        return Text("Belum ada laporan..");
                      }
                      return Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10.0, right: 10.0),
                          child: Material(
                              elevation: 10.0,
                              borderRadius: BorderRadius.circular(8.0),
                              shadowColor: Colors.white,
                              child: Container(
                                  height: 80.0,
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
                                          top: 10.0, left: 10.0, bottom: 10.0),
                                      child: Row(
                                          children: <Widget>[
                                            SizedBox(width: 10.0),
                                            _buildList(context, document2)
                                          ]
                                      )
                                  )
                              )
                          )
                      );
                    });
              });
        });
  }


  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery
        .of(context)
        .size
        .width;

    final pageTitle = Padding(
      padding: EdgeInsets.only(top: 1.0, bottom: 20.0),
      child: Text(
        "Laporkan Kebakaran",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 25.0,
        ),
      ),
    );

    final ReportList = Container(
      height: 500.0,
      child: ListView.builder(
        itemExtent: 100.0,
        itemCount: 2,
        itemBuilder: (context, index) {
          return _buildUserInfo(context, index);
        },
    ));

    final searchBar = Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      height: 50.0,
      width: deviceWidth,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.only(top: 15.0),
          hintText: 'Cari Laporan...',
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.6),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );

    final onlineUsersHeading = Text(
      "Relawan",
      style: TextStyle(
        color: Colors.black.withOpacity(0.6),
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
      ),
    );

    final listOfOnlineUsers = Container(
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: users.map((user) => _buildUserCard(user, context)).toList(),
      ),
    );

    final onlineUsers = Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          onlineUsersHeading,
          SizedBox(
            height: 10.0,
          ),
          listOfOnlineUsers
        ],
      ),
    );
    

    final deviceHeight = MediaQuery
        .of(context)
        .size
        .height;

    _showDialog() {
      return showDialog(
        context: context,

        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            backgroundColor: Color(0xFFfbab66),
            title: new Text("Ayo laporkan kemungkinan kebakaran!"),
            content: new Text(
                "Fitur ini mengumpulkan laporan kamu terhadap potensi kebakaran yang ada di lingkungan kamu.\nKategori yang termasuk dalam laporan ini :\n1. Aktivitas pembakaran sampah yang berbahaya.\n2. Aktivitas pembakaran di sekitar hutan.\n3. Aktivitas api di sekitar rumah.\nLaporan dapat disertakan dengan gambar."
                ),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Lapor"),
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(
                      builder: (context) => new ReportPage()));
                },
              ),
            ],
          );
        },
      );
    }

    final reportBtn = Padding(
      padding: EdgeInsets.only(top: .0),
      child: Container(
        margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
        height: 38.0,
        width: MediaQuery
            .of(context)
            .size
            .width,
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
            onPressed: () {
              _showDialog();
            },
            child: Text(
              'Lapor Dugaan Kebakaran',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Color(0xFFfbab66),
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
                      bottom: deviceHeight * 0.77,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 30.0, left: 30.0, right: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        pageTitle,
                        searchBar,
                        onlineUsers,
                        reportBtn,
                        Text(
                          " Daftar Laporan",
                          style: TextStyle(
                              fontSize: 20
                          ),
                        ), ReportList
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


  Widget _buildUserCard(User user, BuildContext context) {
    final firstName = user.name.split(" ")[0];

    final onlineTag = Positioned(
      bottom: 10.0,
      right: 3.0,
      child: Container(
        height: 15.0,
        width: 15.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2.0),
          color: Colors.lightGreen,
        ),
      ),
    );
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () =>
              Navigator.pushNamed(
                  context, chatDetailsViewRoute, arguments: user.id),
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 8.0),
                height: 70.0,
                width: 70.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(user.photo),
                    fit: BoxFit.cover,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              onlineTag
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
}