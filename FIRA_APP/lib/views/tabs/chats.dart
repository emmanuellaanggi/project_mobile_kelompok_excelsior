import 'package:fira/views/home.dart';
import 'package:fira/views/report.dart';
import 'package:fira/views/tabs/emergency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fira/_routing/routes.dart';
import 'package:fira/models/chat.dart';
import 'package:fira/models/user.dart';
import 'package:fira/utils/colors.dart';

class ChatsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

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

    final chatList = Container(
      height: 500.0,
      child: ListView(
        children: chats.map((chat) => _buildChatTile(chat, context)).toList(),
      ),
    );

    final deviceHeight = MediaQuery.of(context).size.height;

    _showDialog() {
      return showDialog(
        context: context,

        builder: (BuildContext context) {


          // return object of type Dialog
          return AlertDialog(
            backgroundColor: Color(0xFFfbab66),
            title: new Text("Ayo laporkan kemungkinan kebakaran!"),
            content: new Text("Fitur ini ...."),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Lapor"),
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(builder: (context) => new ReportPage()));
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
            onPressed: () {_showDialog();},
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
                      padding: EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
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
                          )
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
          onTap: () => Navigator.pushNamed(context, chatDetailsViewRoute, arguments: user.id),
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

  Widget _buildChatTile(Chat chat, BuildContext context) {
    final unreadCount = Positioned(
      bottom: 9.0,
      right: 0.0,
      child: Container(
        height: 25.0,
        width: 25.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 10.0),
          gradient: primaryGradient,
        ),
        child: Center(
          child: Text(
            chat.unreadCount.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );

    final userImage = InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          userDetailsViewRoute,
          arguments: chat.userId,
        );
      },
      child: Stack(
        children: <Widget>[
          Hero(
            tag: chat.userImage,
            child: Container(
              margin: EdgeInsets.only(right: 8.0, bottom: 10.0),
              height: 70.0,
              width: 70.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(chat.userImage),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
          chat.unreadCount == 0 ? Container() : unreadCount
        ],
      ),
    );

    final userNameMessage = Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            chatDetailsViewRoute,
            arguments: chat.userId,
          );
        },
        child: Container(
          padding: EdgeInsets.only(
            left: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: chat.userName,
                child: Text(
                  chat.userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: <Widget>[userImage, userNameMessage],
      ),
    );
  }
}
