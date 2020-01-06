import 'dart:async';

import 'package:fira/views/tabs/emergency.dart';
import 'package:flutter/material.dart';
import 'package:fira/views/tabs/chats.dart';
import 'package:fira/views/tabs/feeds.dart';
import 'package:fira/views/tabs/notifications.dart';
import 'package:fira/views/tabs/profile.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/services.dart';
import 'package:fira/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  {


  int _currentIndex = 0;
  final List<Widget> _pages = [
    FeedsPage(),
    ChatsPage(),
    Emergency(),
    NotificationsPage(),
    ProfilePage(),
  ];


  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final bottomNavBar = BottomNavigationBar(
      onTap: onTabTapped,
      currentIndex: _currentIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black,
      elevation: 0.0,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          backgroundColor: Color(0xFFfbab66),
          title: Text(
            'Utama',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(LineIcons.archive),
          backgroundColor: Color(0xFFfbab66),
          title: Text(
            'Laporan',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        BottomNavigationBarItem(
          backgroundColor: Color(0xFFfbab66),
          icon: FloatingActionButton(
            backgroundColor: Colors.red,
            child: new Icon(LineIcons.warning),
            elevation: 0),
          title: Text(
            'Darurat',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(LineIcons.bell),
          backgroundColor: Color(0xFFfbab66),
          title: Text(
            'Notifikasi',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(LineIcons.user),
          backgroundColor: Color(0xFFfbab66),
          title: Text(
            'Profil',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );

    return Scaffold(
      bottomNavigationBar: bottomNavBar,
      body:
            _pages[_currentIndex]
      );

  }
}
