import 'package:flutter/material.dart';
import 'package:dvcapp/models/topscorer_model.dart';
import 'package:flutter/rendering.dart';

class TopScorerUI extends StatefulWidget {
  final Future epl;
  final Future laliga;
  final Future bundesliga;
  final Future seriea;
  final Future ligue1;

  TopScorerUI(
      {Key key,
      @required this.epl,
      @required this.laliga,
      @required this.bundesliga,
      @required this.seriea,
      @required this.ligue1})
      : super(key: key);

  @override
  _TopScorerUIState createState() => _TopScorerUIState();
}

class _TopScorerUIState extends State<TopScorerUI>
    with AutomaticKeepAliveClientMixin<TopScorerUI> {
  final TopScorer myTable = new TopScorer();

  List<bool> _selections = [true, false, false, false, false];

  //List.generate(5, (_)=>false);
  Future _table;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _table = widget.epl;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    double cWidth = MediaQuery.of(context).size.width;
    return Container(
      width: cWidth,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          //mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: cWidth,
              child: Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ToggleButtons(
                    fillColor: Colors.green[100],
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
                        'La Liga',
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
                              ? Container(
                                  padding: EdgeInsets.all(50.0),
                                  child: Center(
                                      child: CircularProgressIndicator()))
                              : Container(
                                  width: cWidth,
                                  child: Center(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.vertical,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15.0),
                                          child: Center(
                                            child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 15.0),
                                              child: DataTable(
                                                headingRowHeight: 20,
                                                dataRowHeight: 40,
                                                columnSpacing: 2,
                                                horizontalMargin: 2,
                                                columns: [
                                                  DataColumn(
                                                      label: Text('Name',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12))),
                                                  DataColumn(
                                                      label: Text('Team',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12)),
                                                      numeric: false),
                                                  DataColumn(
                                                      label: Text('Goals',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12)),
                                                      numeric: true),
                                                ],
                                                rows: [
                                                  ...loadRows(snapshot)
                                                  // DataRow(cells: [
                                                  //   DataCell(Text('')),
                                                  // ])
                                                ],
                                              ),
                                            ),
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

  List<DataRow> loadRows(AsyncSnapshot snapshot) {
    List<DataRow> myRows = [];
    for (var i = 0; i < snapshot.data.length; i++) {
      myRows.add(DataRow.byIndex(index: i, cells: <DataCell>[
        DataCell(Container(
          child: Text(snapshot.data[i].name,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
        )),
        //DataCell(Text(snapshot.data[i].nationality)),
        DataCell(Container(
          child: Text(snapshot.data[i].team,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal)),
        )),
        DataCell(Container(
          child: Text(snapshot.data[i].numberOfGoals,
              textAlign: TextAlign.center,
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
