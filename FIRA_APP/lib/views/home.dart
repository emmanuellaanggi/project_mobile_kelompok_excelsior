import 'package:flutter/material.dart';
import 'package:fira/utils/colors.dart';
import 'package:fira/views/tabs/chats.dart';
import 'package:fira/views/tabs/feeds.dart';
import 'package:fira/views/tabs/notifications.dart';
import 'package:fira/views/tabs/profile.dart';
import 'package:line_icons/line_icons.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    FeedsPage(),
    ChatsPage(),
    NotificationsPage(),
    ProfilePage()
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
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey.withOpacity(0.6),
      elevation: 0.0,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text(
            'Utama',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(LineIcons.comments),
          title: Text(
            'Laporan',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(LineIcons.bell),
          title: Text(
            'Notifikasi',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(LineIcons.user),
          title: Text(
            'Profil',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );

    return Scaffold(
      bottomNavigationBar: bottomNavBar,
      body: _pages[_currentIndex],
    );
  }
}
