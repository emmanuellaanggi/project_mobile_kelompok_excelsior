import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fira/views/home.dart';
import 'package:fira/utils/colors.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/services.dart';
import 'package:fira/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';


class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final _formKey = GlobalKey<FormState>();

  var authHandler = new Auth();

  final databaseReference = Firestore.instance;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();

  File galleryFile;
  File cameraFile;
  final hr = Divider();

  Widget displaySelectedFile(File file) {
    return new Column(children: <Widget>[
      hr,
      SizedBox(
        child: file == null
            ? new Text('Sorry nothing selected!!')
            : new Image.file(file),
    )
    ]);

  }

  @override
  Widget build(BuildContext context) {

    imageSelectorGallery() async {
      galleryFile = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        // maxHeight: 50.0,
        // maxWidth: 50.0,
      );
      print("You selected gallery image : " + galleryFile.path);
      setState(() {});
    }

    //display image selected from camera
    imageSelectorCamera() async {
      cameraFile = await ImagePicker.pickImage(
        source: ImageSource.camera,
        //maxHeight: 50.0,
        //maxWidth: 50.0,
      );
      print("You selected camera image : " + cameraFile.path);
      setState(() {});
    }

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

    final pageTitle = Container(
      child: Text(
        "Deskripsi Laporan Potensi Kebakaran",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 30.0,
        ),
      ),
    );

    final formFieldSpacing = SizedBox(
      height: 20.0,
    );

    final registerForm = Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _buildFormName('Judul Laporan', LineIcons.mail_forward),
            formFieldSpacing,
            _buildFormEmail('Deskripsi Laporan', LineIcons.file_text),
            formFieldSpacing,
            _buildFormLocation("Lokasi", LineIcons.location_arrow),
            formFieldSpacing
          ],
        ),
      ),
    );

    Future<String> getUser() async {
      FirebaseUser user = await FirebaseAuth.instance.currentUser();

      String users = user.uid;
      return users;
    }

    Widget insertdata(BuildContext context) {
      return FutureBuilder<String>(
          future: getUser(), // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return new StreamBuilder(
                stream: Firestore.instance.
                collection('users').
                where('uid', isEqualTo: '${snapshot.data}').
                snapshots(),
                builder: (context, snapshot) {
                  DocumentSnapshot document = snapshot.data.documents[0];
                  if (!snapshot.hasData) {
                    return Text("Loading..");
                  }
                  return new StreamBuilder(
                      stream: Firestore.instance
                          .collection("users")
                          .document(document['uid'])
                          .collection("laporan")
                          .orderBy("id_laporan", descending: true).snapshots(),
                      builder: (context, snapshot2) {
                        DocumentSnapshot document2 = snapshot2.data
                            .documents[0];
                        var one = int.parse(document2["id_laporan"]);
                        var two = one + 1;
                        String id_laporan = two.toString();

                        return Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Container(
                            margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
                            height: 60.0,
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
                                  Firestore.instance.
                                  collection("users")
                                      .document(document['uid'])
                                      .collection("laporan")
                                      .document(id_laporan)
                                      .setData({
                                    "status": "Terkirim",
                                    "Nama Pelapor": document['name'],
                                    "Laporan": nameController.text,
                                    "Deskripsi Laporan": emailController.text,
                                    "Lokasi" : locationController.text,
                                    "id_laporan": id_laporan,
                                  }).catchError((e) =>
                                      _showDialogError(e.toString()));
                                  _showDialog();
                                },
                                child: Text(
                                  'Masukkan Laporan',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                });
          });
    }

    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

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
                appBar,
                Container(
                  padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      pageTitle,
                      registerForm,
                      new FloatingActionButton(
                        backgroundColor: Colors.red,
                        child: new Icon(LineIcons.camera),
                        onPressed: imageSelectorCamera,
                      ),
                      new Container(
                          child: Column(
                            children: <Widget>[
                              displaySelectedFile(cameraFile),
                              insertdata(context)
                            ],
                          )
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

  Widget _buildFormName(String label, IconData icon) {
    return TextFormField(
      controller: nameController,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        prefixIcon: Icon(
          icon,
          color: Colors.black38,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
    );
  }

  Widget _buildFormLocation(String label, IconData icon) {
    return TextFormField(
      controller: locationController,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        prefixIcon: Icon(
          icon,
          color: Colors.black38,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
    );
  }


  Widget _buildFormEmail(String label, IconData icon) {
    return TextFormField(
      maxLines: 3,
      controller: emailController,
      decoration: InputDecoration(
        labelText: 'Deskripsi Laporan',
        labelStyle: TextStyle(color: Colors.black),
        prefixIcon: Icon(
          icon,
          color: Colors.black38,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(color: Colors.black),
      validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
      cursorColor: Colors.black,
    );
  }



  FutureOr _showDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Terima Kasih"),
          content: new Text("Laporan anda akan kami tindak lanjuti secepat mungkin"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Lanjut"),
              onPressed: () {
                Navigator.push(context, new MaterialPageRoute(builder: (context) => new HomePage()));
              },
            ),
          ],
        );
      },
    );
  }

  FutureOr _showDialogError(String e) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Oops!"),
          content: new Text(e),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ulangi"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
