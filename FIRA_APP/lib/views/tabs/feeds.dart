import 'package:fira/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:fira/_routing/routes.dart';
import 'package:line_icons/line_icons.dart';
import 'package:fira/utils/colors.dart';
import 'package:fira/utils/utils.dart';

class FeedsPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    final featureHeading = Text(
      "Fitur",
      style: TextStyle(
        color: Colors.black.withOpacity(0.6),
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
      ),
    );

    final listOfFeature = Container(
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: features.map((feature) => _buildUserCard(feature, context)).toList(),
      ),
    );

    final onlineFeature = Container(
      margin: EdgeInsets.only(top: 20.0, left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          featureHeading,
          SizedBox(
            height: 10.0,
          ),
          listOfFeature
        ],
      ),
    );

    final hr = Divider();

    final secondCard = Padding(
      padding: EdgeInsets.only(top:10.0, right: 20.0, left: 20.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(8.0),
        shadowColor: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: <Widget>[
              hr,
              _buildIconTile(context, AvailableImages.appLogo, Colors.green, 'Pertolongan Pertama Pada Api', homeViewRoute),
              hr
            ],
          ),
        ),
      ),
    );

    final thirdCard = Padding(
      padding: EdgeInsets.only(top:10.0, right: 20.0, left: 20.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(8.0),
        shadowColor: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: <Widget>[
              hr,
              _buildIconTile(context, AvailableImages.appLogo, Colors.pink, 'Apa yang harus dilakukan ketika melihat kebakaran hutan?', homeViewRoute),
              hr
            ],
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
                    padding: EdgeInsets.only(top: 120.0, left: 15.0, right: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        onlineFeature,
                        secondCard,
                        thirdCard,
                        secondCard
                      ],
                    ),
                  ),
                  Positioned( top: 30, child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Container(
                      height: 150.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AvailableImages.appLogo,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  ),
                ]),
            ],
          ),
        ),
      ),
    );

  }
}

Widget _buildIconTile(BuildContext context, AssetImage image, Color color, String title, String route) {
  return ListTile(
    title: Text(title, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),),
    leading: Container(
      height: 40.0,
      width: 70.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(child: Image(image: image,)),
    ),
    trailing: Icon(LineIcons.chevron_circle_right),
    onTap: () => Navigator.pushNamed(context, route),
  );
}

Widget _buildUserCard(Feature feature, BuildContext context) {
  final firstName = feature.name.split(" ")[0];

  return Column(
    children: <Widget>[
      InkWell(
        onTap: () => {},
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 8.0),
              height: 70.0,
              width: 70.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(feature.photo),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
              ),
            ),
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