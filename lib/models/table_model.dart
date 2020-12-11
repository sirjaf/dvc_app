import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class TableLeague {
  final String name;
  final String crestUrl;
  final String position;
  final String playedGames;
  final String won;
  final String draw;
  final String lost;
  final String points;
  final String goalsFor;
  final String goalsAgainst;
  final String goalDifference;

  TableLeague(
      {this.name,
      this.crestUrl,
      this.position,
      this.playedGames,
      this.won,
      this.draw,
      this.lost,
      this.points,
      this.goalsFor,
      this.goalsAgainst,
      this.goalDifference});

  factory TableLeague.fromJson(Map<String, dynamic> parsedJson) {
    // return TableLeague(name: parsedJson['standings'][0]['table'][0]['team']['name'],
    //   crestUrl: parsedJson['standings'][0]['table'][0]['team']['crestUrl'],
    //   position: parsedJson['standings'][0]['table']['position'],
    //   playedGames: parsedJson['standings'][0]['table']['playedGames'],
    //   won: parsedJson['standings'][0]['table']['won'],
    //   draw: parsedJson['standings'][0]['table']['draw'],
    //   lost: parsedJson['standings'][0]['table']['lost'],
    //   points:parsedJson['standings'][0]['table']['points'],
    //   goalsFor: parsedJson['standings'][0]['table']['goalsFor'],
    //   goalsAgainst: parsedJson['standings'][0]['table']['goalsAgainst'],
    //   goalDifference: parsedJson['standings'][0]['table']['goalDifference']);

    return TableLeague(
        name: parsedJson['team']['name'],
        crestUrl: parsedJson['team']['crestUrl'],
        position: parsedJson['position'].toString(),
        playedGames: parsedJson['playedGames'].toString(),
        won: parsedJson['won'].toString(),
        draw: parsedJson['draw'].toString(),
        lost: parsedJson['lost'].toString(),
        points: parsedJson['points'].toString(),
        goalsFor: parsedJson['goalsFor'].toString(),
        goalsAgainst: parsedJson['goalsAgainst'].toString(),
        goalDifference: parsedJson['goalDifference'].toString());
  }

  Future<List<TableLeague>> loadTable(String tableJson) async {
    List<TableLeague> leagueTable = [];
    String myj =
        await rootBundle.loadString(tableJson); //'jsonfiles/today.json');
    var convJson = jsonDecode(myj);
    List<dynamic> mystanding = convJson['standings'][0]['table'];
    leagueTable = mystanding.map((f) => TableLeague.fromJson(f)).toList();
    print(leagueTable.length);
    return leagueTable;
    //String teamA =myData[0]['teamA'];
    //return myData;
  }

  Future<List<TableLeague>> loadTableOnline(var tableJson) async {
    List<TableLeague> leagueTable = [];
    var myj = await http.get(tableJson, headers: {
      'Content-Type': 'application/json'
    }); //'jsonfiles/today.json');

    if (myj.statusCode == 200) {
      var convJson = jsonDecode(utf8.decode(myj.bodyBytes));
      List<dynamic> mystanding = convJson['standings'][0]['table'];
      leagueTable = mystanding.map((f) => TableLeague.fromJson(f)).toList();
      print(leagueTable.length);
      return leagueTable;
    } else {
      //throw Exception('Failed to load Table');
      print('Failed to load post');
      return leagueTable;
    }

    //String teamA =myData[0]['teamA'];
    //return myData;
  }
}
