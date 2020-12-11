import 'package:flutter/material.dart';

class DateHeader extends StatefulWidget {
  final String myDate;
  DateHeader({Key key, @required this.myDate}) : super(key: key);

  @override
  _DateHeaderState createState() => _DateHeaderState();
}

class _DateHeaderState extends State<DateHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        color: Colors.black,
        child: Text(
          widget.myDate,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
    );
    
  }
}
