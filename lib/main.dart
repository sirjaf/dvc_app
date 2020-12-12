import 'dart:async';

import 'package:dvcapp/screens/myHomePage.dart';
import 'package:flutter/material.dart';
import 'package:dvcapp/screens/offline.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

void main() async {
  var status;
  status = await checkkInternetConnection();
//   if (status) {
//     runApp(MyHomePage(
//         title: 'Dawaki Viewing Center', appBarColor: Colors.green[500]));
//     //runApp(MyApp());
//   } else {
//     runApp(Offline(title: 'You are Offline'));
//   }
  runApp(Offline(title: 'You are Offline', mstatus: status));
}

Future<bool> checkkInternetConnection() async {
  return await DataConnectionChecker().hasConnection;
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dawaki Viewing Center',
      theme: ThemeData(
        primarySwatch: Colors.green[500],
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SafeArea(
          child: MyHomePage(
              title: 'Dawaki Viewing Center', appBarColor: Colors.green[500])),
    );
  }
}
