import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';
// import 'dart:io';


class OfflineData extends StatelessWidget {
  final String title;
  OfflineData({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(40),
          color: Colors.red,
          child: Text("You are Offline. Please connect to Mobile or WIFI data",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}
