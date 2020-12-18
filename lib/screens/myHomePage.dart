import 'package:dvcapp/models/fixture_model.dart';
import 'package:dvcapp/models/table_model.dart';
import 'package:dvcapp/models/topscorer_model.dart';
import 'package:dvcapp/screens/stat.dart';
import 'package:dvcapp/screens/today.dart';
import 'package:dvcapp/screens/topScorer.dart';
import 'package:dvcapp/screens/upcoming.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/components/tabs/gf_tabbar.dart';
import 'package:getflutter/components/tabs/gf_tabbar_view.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  final Color appBarColor;
  MyHomePage({Key key, this.title, this.appBarColor}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TableLeague _myTable = new TableLeague();
  final TopScorer _myTopScorer = new TopScorer();
  Fixture _myFixture = new Fixture();

  static String baseURL = 'http://carwash.jaafarprojects.website';

  final String _todayFixUrl = '$baseURL/api/fixtures/today';
  final String _upcomingFixUrl = '$baseURL/api/fixtures/upcoming/';
  final String _eplUrl = '$baseURL/json/epl.json';
  final String _laligaUrl = '$baseURL/json/laliga.json';
  final String _bundesligaUrl = '$baseURL/json/bundesliga.json';
  final String _serieaUrl = '$baseURL/json/seriea.json';
  final String _ligue1Url = '$baseURL/json/ligue1.json';
  final String _tseplUrl = '$baseURL/json/tsepl.json';
  final String _tslaligaUrl = '$baseURL/json/tslaliga.json';
  final String _tsbundesligaUrl = '$baseURL/json/tsbundesliga.json';
  final String _tsserieaUrl = '$baseURL/json/tsseriea.json';
  final String _tsligue1Url = '$baseURL/json/tsligue1.json';

  Future _todayFix;
  Future _upComingFix;
  Future _epl;
  Future _laliga;
  Future _bundesliga;
  Future _seriea;
  Future _ligue1;
  Future _tsepl;
  Future _tslaliga;
  Future _tsbundesliga;
  Future _tsseriea;
  Future _tsligue1;

  //var vsync = TickerProvider;
  @override
  void initState() {
    super.initState();

    _todayFix = _myFixture.loadFixturesOnline(_todayFixUrl);
    _upComingFix = _myFixture.loadFixturesOnline(_upcomingFixUrl);
    _epl = _myTable.loadTableOnline(_eplUrl);
    _laliga = _myTable.loadTableOnline(_laligaUrl);
    _bundesliga = _myTable.loadTableOnline(_bundesligaUrl);
    _seriea = _myTable.loadTableOnline(_serieaUrl);
    _ligue1 = _myTable.loadTableOnline(_ligue1Url);

    _tsepl = _myTopScorer.loadTableOnline(_tseplUrl);
    _tslaliga = _myTopScorer.loadTableOnline(_tslaligaUrl);
    _tsbundesliga = _myTopScorer.loadTableOnline(_tsbundesligaUrl);
    _tsseriea = _myTopScorer.loadTableOnline(_tsserieaUrl);
    _tsligue1 = _myTopScorer.loadTableOnline(_tsligue1Url);
    //loadJson();
    print(_todayFix.toString());
    print(_upComingFix.toString());
  }

  @override
  Widget build(BuildContext context) {
    //double cWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Image.asset("images/app-icon.png")),
          ),
          title: Text(widget.title),
          backgroundColor: widget.appBarColor,
          centerTitle: true,
        ),
        body: GFTabBarView(
          children: <Widget>[
            Today(
              todayFix: _todayFix,
            ),
            UpComing(
              upcomingFix: _upComingFix,
            ),
            Stat(
              epl: _epl,
              laliga: _laliga,
              bundesliga: _bundesliga,
              seriea: _seriea,
              ligue1: _ligue1,
            ),
            TopScorerUI(
                epl: _tsepl,
                laliga: _tslaliga,
                bundesliga: _tsbundesliga,
                seriea: _tsseriea,
                ligue1: _tsligue1),
          ],
        ),
        bottomNavigationBar: GFTabBar(
          //initialIndex: 0,
          length: 4,
          tabBarColor: Colors.blueGrey,
          indicatorColor: Colors.white,
          indicatorWeight: 5,
          tabBarHeight: 60.0,
          labelStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
          //controller: tabController,
          tabs: [
            Tab(
                // child: Text(
                //   "Today",
                // ),
                text: "Today",
                icon: Image.asset(
                  'images/today.png',
                  //width: cWidth / 4,
                  width: 24.0,
                  semanticLabel: 'Todays Fixture',
                  fit: BoxFit.cover,
                ),
                iconMargin: EdgeInsets.only(bottom: 10.0)),
            Tab(
                // child: Text(
                //   "Upcoming",
                // ),
                text: "Upcoming",
                icon: Image.asset(
                  'images/upcoming.png',
                  //width: cWidth / 4,
                  width: 24.0,
                  semanticLabel: 'Upcoming Fixture',
                  fit: BoxFit.cover,
                ),
                iconMargin: EdgeInsets.only(bottom: 10.0)),
            Tab(
                // child: Text(
                //   "Table",
                // ),
                text: "Table",
                icon: Image.asset(
                  'images/table.png',
                  //width: cWidth / 4,
                  width: 24.0,
                  semanticLabel: 'Table Ranking',
                  fit: BoxFit.cover,
                ),
                iconMargin: EdgeInsets.only(bottom: 10.0)),
            Tab(
                // child: Text(
                //   "Top Scorers",
                // ),
                text: "Scorers",
                icon: Image.asset(
                  'images/top-scorer.png',
                  //width: cWidth / 4,
                  width: 24.0,
                  semanticLabel: 'Todays Fixture',
                  fit: BoxFit.cover,
                ),
                iconMargin: EdgeInsets.only(bottom: 10.0)),
          ],
        ),
      ),
    );
  }
}
