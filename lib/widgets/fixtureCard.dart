import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class FixtureCard extends StatefulWidget {
  final String teamA;
  final String teamB;
  final String crestTeamA;
  final String crestTeamB;
  final String tournament;
  final String date;
  final String time;

  FixtureCard(
      {Key key,
      @required this.teamA,
      @required this.teamB,
      @required this.crestTeamA,
      @required this.crestTeamB,
      @required this.tournament,
      @required this.time,
      this.date})
      : super(key: key);

  @override
  _FixtureCardState createState() => _FixtureCardState();
}

class _FixtureCardState extends State<FixtureCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      FadeInImage.assetNetwork(
                        placeholder: 'images/team-badge.png',
                        image: widget.crestTeamA,
                        imageSemanticLabel: 'Team Crest',
                        width: 32.0,
                        height: 32.0,
                      ),
                      Text(
                        widget.teamA,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 80,
                child: Container(
                  width: 130,
                  padding: EdgeInsets.all(10),
                  color: Colors.green[500],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.tournament,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                      Text(
                        widget.time,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      if (widget.date != null)
                        Text(widget.date,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.white))
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      FadeInImage.assetNetwork(
                        placeholder: 'images/team-badge.png',
                        image: widget.crestTeamB,
                        imageSemanticLabel: 'Team Crest',
                        width: 32.0,
                        height: 32.0,
                      ),
                      Text(
                        widget.teamB,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
