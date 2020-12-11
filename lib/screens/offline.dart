import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dvcapp/screens/myHomePage.dart';
import 'package:flutter/material.dart';

class Offline extends StatefulWidget {
  final String title;
  Offline({Key key, this.title}) : super(key: key);

  @override
  _OfflineState createState() => _OfflineState();
}

class _OfflineState extends State<Offline> {
  bool status = true;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dawaki Viewing Center',
      theme: ThemeData(primaryColor: Colors.green[500]),
      home: SafeArea(
          child: status
              ? offLineBody()
              : MyHomePage(
                  title: 'Dawaki Viewing Center',
                  appBarColor: Colors.green[500])),
    );
  }

  Future<bool> checkkInternetConnection() async {
    return await DataConnectionChecker().hasConnection;
  }

  // ignore: missing_return
  Widget offLineBody() {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.title}'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Container(
          //padding: EdgeInsets.all(40),
          width: double.infinity,
          //color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.red,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                      "You are Offline. Please connect to Mobile or WIFI data",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 20.0,
              ),
              RaisedButton(
                onPressed: () async {
                  bool mstatus = false;
                  mstatus = await checkkInternetConnection();
                  setState(() {
                    status = !mstatus;
                  });
                },
                child: Text("Retry",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600)),
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}
