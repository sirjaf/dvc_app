import 'package:dvcapp/widgets/fixtureCard.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dvcapp/widgets/dateHeader.dart';

//import 'dart:core';
class UpComing extends StatefulWidget {
  final Future upcomingFix;

  UpComing({Key key, this.upcomingFix}) : super(key: key);

  String convDate(String strTime) {
    DateTime now = DateTime.parse(strTime);
    return DateFormat.yMMMMEEEEd().format(now).toString();
  }

  String convTime(String strDate) {
    DateTime now = DateTime.parse(strDate);
    return DateFormat.jm().format(now).toString();
  }

  @override
  _UpComingState createState() => _UpComingState();
}

class _UpComingState extends State<UpComing>
    with AutomaticKeepAliveClientMixin<UpComing> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Center(
        child: FutureBuilder(
            future: widget.upcomingFix, //_myFixture.loadFixtures(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              String myDate;

              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              int itemCount = snapshot.data.length;

              if (itemCount == 0) {
                return Center(
                  child: Text(
                    "No Upcoming Fixtures.",
                    style: TextStyle(fontSize: 14),
                  ),
                );
              }
              return Container(
                //padding: const EdgeInsets.only(top: 10),
                child: ListView.separated(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    if ((myDate == null) ||
                        (myDate !=
                            widget.convDate(
                                snapshot.data[index].date.toString()))) {
                      myDate =
                          widget.convDate(snapshot.data[index].date.toString());
                      return Center(
                          child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: DateHeader(myDate: myDate),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FixtureCard(
                              teamA: snapshot.data[index].teamA,
                              teamB: snapshot.data[index].teamB,
                              crestTeamA: snapshot.data[index].crestTeamA,
                              crestTeamB: snapshot.data[index].crestTeamB,
                              tournament: snapshot.data[index].tournament,
                              time: widget.convTime(
                                  snapshot.data[index].date.toString() +
                                      ' ' +
                                      snapshot.data[index].time.toString()),
                              //date: widget.convDate(snapshot.data[index].date.toString()),
                            ),
                          )
                        ],
                      ));
                    }

                    return FixtureCard(
                      teamA: snapshot.data[index].teamA,
                      teamB: snapshot.data[index].teamB,
                      crestTeamA: snapshot.data[index].crestTeamA,
                      crestTeamB: snapshot.data[index].crestTeamB,
                      tournament: snapshot.data[index].tournament,
                      time: widget.convTime(
                          snapshot.data[index].date.toString() +
                              ' ' +
                              snapshot.data[index].time.toString()),
                      //date: widget.convDate(snapshot.data[index].date.toString()),
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
