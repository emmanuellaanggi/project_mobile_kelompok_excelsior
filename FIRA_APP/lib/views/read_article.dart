import 'package:flutter/material.dart';
import 'package:fira/utils/colors.dart';
import 'package:fira/utils/utils.dart';


class ReadArticle extends StatefulWidget {
  @override
  _ReadArticle createState() => _ReadArticle();
}

class _ReadArticle extends State<ReadArticle> {
  final _formKey = GlobalKey<FormState>();

  final hr = Divider();


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
        "ARTICLE",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 25.0,
        ),
      ),
    ));

    final pageContainer = Center(child: Container(
      padding: EdgeInsets.only(left: 12.0, right: 10.0),
      child: Text(
        "\nMengenali Jenis Luka Bakar\n\nAda beberapa faktor yang bisa menyebabkan luka bakar, seperti paparan sinar matahari berlebih, sengatan listrik, api atau kebakaran, dan luka bakar karena terpapar bahan kimiawi. Melihat dari tingkatannya, luka bakar yang dialami seseorang dapat dikategorikan sebagai berikut:\nLuka bakar ringan\nLuka bakar ringan bisa disebut dengan luka bakar derajat 1 yang memiliki ciri luas area luka tidak lebih dari 8 centimeter (cm). Selain itu, luka jenis ini hanya meliputi kulit bagian paling luar dan dianggap tidak serius. Gejala yang muncul, biasanya seperti rasa sakit, kemerahan, dan bengkak. Contoh luka bakar derajat pertama yaitu luka bakar pada permukaan kulit yang terbakar sinar matahari secara langsung.\nLuka bakar sedang\nLuka bakar sedang adalah luka bakar derajat 2 yang memiliki ciri kulit melepuh, sangat perih dan kemerahan. Luka bakar jenis ini memerlukan perawatan medis darurat, terutama jika luka bakar meluas di area penting, seperti wajah, tangan, bokong, selangkangan atau paha dan kaki. Sebagian luka bakar derajat 2 membutuhkan waktu penyembuhan lebih dari tiga minggu.\nLuka bakar berat\nLuka bakar berat atau luka bakar tingkat 3 termasuk luka bakar yang serius, karena merusak seluruh lapisan kulit dan lemak, bahkan bisa sampai ke otot dan tulang. Korban kebakaran yang mengalami luka bakar berat dapat mengalami keracunan karbon monoksida, sesak napas atau kulit yang terbakar hangus.",
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
          fontSize: 13.0,
        ),
      ),
    ));


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
                          pageTitle,
                          pageContainer,
                          Divider()
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
