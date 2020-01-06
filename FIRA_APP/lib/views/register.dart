import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fira/views/home.dart';
import 'package:fira/utils/colors.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/services.dart';
import 'package:fira/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {

  RegisterPage({this.authHandler, this.loginCallback});

  final Auth authHandler;
  final VoidCallback loginCallback;


  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  var authHandler = new Auth();
  final databaseReference = Firestore.instance;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  int _genderRadioBtnVal = -1;

  void _handleGenderChange(int value) {
    setState(() {
      _genderRadioBtnVal = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = Padding(
      padding: EdgeInsets.only(bottom: 40.0),
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
        "Ayo bantu kami menghindari api!",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 30.0,
        ),
      ),
    );

    final formFieldSpacing = SizedBox(
      height: 30.0,
    );

    final registerForm = Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _buildFormName('Name', LineIcons.user),
            formFieldSpacing,
            _buildFormEmail('Email Address', LineIcons.envelope),
            formFieldSpacing,
            _buildFormPhone('Phone Number', LineIcons.mobile_phone),
            formFieldSpacing,
            _buildFormPassword('Password', LineIcons.lock),
            formFieldSpacing,
          ],
        ),
      ),
    );

    final gender = Padding(
      padding: EdgeInsets.only(top: 0.0),
      child: Row(
        children: <Widget>[
          Radio(
            value: 0,
            groupValue: _genderRadioBtnVal,
            onChanged: _handleGenderChange,
          ),
          Text("Pria"),
          Radio(
            value: 1,
            groupValue: _genderRadioBtnVal,
            onChanged: _handleGenderChange,
          ),
          Text("Wanita"),
          Radio(
            value: 2,
            groupValue: _genderRadioBtnVal,
            onChanged: _handleGenderChange,
          ),
          Text("Lainnya"),
        ],
      ),
    );

    String _gender;

    switch(_genderRadioBtnVal) {
      case 0: { _gender = "Pria"; }
      break;

      case 1: { _gender = "Wanita"; }
      break;

      default: { _gender = "Lainnya"; }
      break;
    }

    final submitBtn = Padding(
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
            onPressed:() { authHandler.handleSignUp(emailController.text, passwordController.text)
                .then((currentUser) => Firestore.instance
                .collection("users")
                .document(currentUser.uid)
                .setData({
              "uid": currentUser.uid,
              "name": nameController.text,
              "phone": phoneController.text,
              "email": emailController.text,
              "gender" : _gender,
            })).catchError((e) => _showDialogError(e.toString())); _showDialog();
            authHandler.getUser()
                .then((currentUser) => Firestore.instance.collection("users")
                .document(currentUser.uid)
                .collection("laporan")
                .document("0")
                .setData({
              "id_laporan" : "0"
            }));
            },
            child: Text(
              'CREATE ACCOUNT',
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
                    Positioned(top:15.0, child: appBar,),
                    Container(
                      padding: EdgeInsets.only(top: 60.0, left: 40.0, right: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          pageTitle,
                          registerForm,
                          gender,
                          submitBtn
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

  Widget _buildFormPhone(String label, IconData icon) {
    return TextFormField(
      controller: phoneController,
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
      keyboardType: TextInputType.phone,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
    );
  }

  Widget _buildFormEmail(String label, IconData icon) {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        labelText: 'Email Adress',
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

  Widget _buildFormPassword(String label, IconData icon) {
    return TextFormField(
      controller: passwordController,
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
      validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      obscureText: true,
    );
  }

  void createRecord() async {
    String gender;

    switch(_genderRadioBtnVal) {
      case 0: { gender = "Pria"; }
      break;

      case 1: { gender = "Wanita"; }
      break;

      default: { gender = "Lainnya"; }
      break;
    }
    DocumentReference ref = await databaseReference.collection("user")
        .add({
      'email': emailController.text,
      'nama' : nameController.text,
      'phone' : phoneController.text,
      'gender' : gender
    });
    print(ref.documentID);
  }

  FutureOr _showDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Selamat!"),
          content: new Text("Email dan Password kamu sudah terdaftar"),
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
