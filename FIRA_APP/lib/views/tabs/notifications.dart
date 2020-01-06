import 'package:flutter/material.dart';
import 'package:fira/utils/utils.dart';
import 'package:fira/utils/colors.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    final pageTitle = Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
      child: Text(
        "Notifications",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 20.0,
        ),
      ),
    );

    final image = Image.asset(
      AvailableImages.emptyState['assetPath'],
    );

    final notificationHeader = Container(
      padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: Text(
        "No New Notification",
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.0),
      ),
    );
    final notificationText = Text(
      "You currently do not have any unread notifications.",
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
        color: Colors.black.withOpacity(0.6),
      ),
      textAlign: TextAlign.center,
    );

    return Scaffold(
        backgroundColor: Color(0xFFfbab66),
      body: SingleChildScrollView(
        child: new Container(
          decoration: BoxDecoration(gradient: primaryGradient),
        padding: EdgeInsets.only(
          top: 40.0,
          left: 30.0,
          right: 30.0,
          bottom: 50.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            pageTitle,
            SizedBox(
              height: deviceHeight * 0.1,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[image, notificationHeader, notificationText],
            ),
          ],
        ),
      ),)
    );
  }
}
