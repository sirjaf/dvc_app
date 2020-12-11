import 'package:flutter/material.dart';
import 'package:dvcapp/models/table_model.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'package:flutter/services.dart';

class Stat extends StatefulWidget {
  final Future epl;
  final Future laliga;
  final Future bundesliga;
  final Future seriea;
  final Future ligue1;

  Stat(
      {Key key,
      this.epl,
      this.laliga,
      this.bundesliga,
      this.seriea,
      this.ligue1})
      : super(key: key);

  @override
  _StatState createState() => _StatState();
}

class _StatState extends State<Stat> with AutomaticKeepAliveClientMixin<Stat> {
  final TableLeague myTable = new TableLeague();

  // Future _epl;
  // Future _laliga;
  // Future _bundesliga;
  // Future _seriea;
  // Future _ligue1;
  Future _table;

  List<bool> _selections = [
    true,
    false,
    false,
    false,
    false
  ]; //List.generate(5, (_)=>false);

  @override
  void initState() {
    super.initState();
    _table = widget.epl;
    // initialTables();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double cWidth = MediaQuery.of(context).size.width;
    return Container(
      width: cWidth,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              width: cWidth,
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ToggleButtons(
                    constraints: BoxConstraints(
                      minHeight: 40,
                      minWidth: cWidth / 5,
                    ),
                    selectedColor: Colors.black,
                    selectedBorderColor: Colors.white,
                    renderBorder: true,
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    children: <Widget>[
                      Text(
                        'EPL',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        'LaLiga',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Serie A',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Bundesliga',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Lique 1',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                    isSelected: _selections,
                    onPressed: (int index) {
                      setState(() => {
                            // _selections[index] = !_selections[index]

                            for (var i = 0; i < _selections.length; i++)
                              {
                                if (i != index) {_selections[i] = false}
                              },
                            _selections[index] = true,
                            _table = standingJson(index)
                          });
                    },
                  ),
                ),
              ),
            ),
            Container(
              width: cWidth,
              child: Center(
                child: FutureBuilder(
                    future: _table,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return Container(
                          child: !snapshot.hasData
                              ? Column(
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.all(50.0),
                                        child: Center(
                                            child:
                                                CircularProgressIndicator())),
                                  ],
                                )
                              : Container(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 15.0),
                                        child: Container(
                                          padding: EdgeInsets.only(right: 8),
                                          child: DataTable(
                                            headingRowHeight: 20,
                                            dataRowHeight: 40,
                                            columnSpacing: 2,
                                            horizontalMargin: 2,
                                            columns: [
                                              DataColumn(
                                                  label: Align(
                                                alignment: Alignment.topCenter,
                                                child: Text('Pos',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12)),
                                              )),
                                              DataColumn(label: Text('')),
                                              DataColumn(
                                                  label: Align(
                                                alignment: Alignment.topCenter,
                                                child: Text('Team',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12)),
                                              )),
                                              DataColumn(
                                                  label: Align(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: Text('Pld',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12)),
                                                  ),
                                                  numeric: true),
                                              DataColumn(
                                                  label: Align(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: Text('Pts',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12)),
                                                  ),
                                                  numeric: true),
                                              DataColumn(
                                                  label: Align(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: Text('GD',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12)),
                                                  ),
                                                  numeric: true),
                                            ],
                                            rows: [
                                              ...loadRows(snapshot, context)
                                              // DataRow(cells: [
                                              //   DataCell(Text('')),
                                              // ])
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<DataRow> loadRows(AsyncSnapshot snapshot, BuildContext context) {
    List<DataRow> myRows = [];
    for (var i = 0; i < snapshot.data.length; i++) {
      myRows.add(DataRow.byIndex(index: i, cells: <DataCell>[
        DataCell(Align(
            alignment: Alignment.centerLeft,
            child: Text(
              snapshot.data[i].position,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ))),
        // DataCell(Center(
        //     child: FadeInImage.assetNetwork(
        //   placeholder: 'images/placeholder.png',
        //   bundle: DefaultAssetBundle.of(context),
        //   image: snapshot.data[i].crestUrl.toString(),
        // ))),
        DataCell(Center(
          child: SvgPicture.network(
            snapshot.data[i].crestUrl.toString(),
            // placeholderBuilder: (context) => CircularProgressIndicator(),
            placeholderBuilder: (context) => Image.asset(
              'images/team-badge.png',
              //width: cWidth / 4,
              width: 16.0,
              semanticLabel: 'Todays Fixture',
              fit: BoxFit.cover,
            ),
            semanticsLabel: 'Team Crest',
            height: 50.0,
            width: 50.0,
          ),
        )),
        DataCell(Container(
          child: Text(snapshot.data[i].name,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
        )),
        DataCell(Container(
          child: Text(snapshot.data[i].playedGames,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
        )),
        DataCell(Container(
          child: Text(snapshot.data[i].points,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
        )),
        DataCell(Container(
          child: Text(snapshot.data[i].goalDifference,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
        )),
      ]));
    }

    return myRows;
  }

  Future standingJson(int index) {
    switch (index) {
      case 0:
        return widget.epl;
        break;
      case 1:
        return widget.laliga;
        break;
      case 2:
        return widget.seriea;
        break;
      case 3:
        return widget.bundesliga;
        break;
      case 4:
        return widget.ligue1;
        break;
      default:
        return widget.epl;
    }
  }
}
