import 'package:dvcapp/widgets/fixtureCard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:core';

class Today extends StatefulWidget {
  final Future todayFix;
  Today({Key key, this.todayFix}) : super(key: key);

  String convTime(String strTime) {
    DateTime now = DateTime.parse(strTime);
    return DateFormat.jm().format(now).toString();
  }

  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today>
    with AutomaticKeepAliveClientMixin<Today> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Center(
        child: FutureBuilder(
            future: widget.todayFix, //_myFixture.loadFixtures(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              int itemCount = snapshot.data.length;
              if (itemCount == 0) {
                return Center(
                  child: Text(
                    "No Fixtures For Today.",
                    style: TextStyle(fontSize: 14),
                  ),
                );
              }

              return Container(
                //padding: EdgeInsets.only(top: 15),
                child: ListView.separated(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FixtureCard(
                        teamA: snapshot.data[index].teamA,
                        teamB: snapshot.data[index].teamB,
                        crestTeamA: snapshot.data[index].crestTeamA,
                        crestTeamB: snapshot.data[index].crestTeamB,
                        tournament: snapshot.data[index].tournament,
                        time: widget.convTime(
                            snapshot.data[index].date.toString() +
                                ' ' +
                                snapshot.data[index].time
                                    .toString()) //snapshot.data[index].time,
                        );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                ),
              );
            }),
      ),
    );
  }
}
