import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Fixture {
  String id;
  String name;
  String teamA;
  String teamB;
  String crestTeamA;
  String crestTeamB;
  String tournament;
  String country;
  String date;
  String time;
  String price;

  Fixture(
      {this.id,
      this.name,
      this.teamA,
      this.teamB,
      this.crestTeamA,
      this.crestTeamB,
      this.tournament,
      this.country,
      this.date,
      this.time,
      this.price});

  factory Fixture.fromJson(Map<String, dynamic> parsedJson) {
    return Fixture(
        id: parsedJson['id'],
        name: parsedJson['name'],
        teamA: parsedJson['teamA'],
        teamB: parsedJson['teamB'],
        crestTeamA: parsedJson['crest_teamA'],
        crestTeamB: parsedJson['crest_teamB'],
        tournament: parsedJson['tournament'],
        country: parsedJson['country'],
        date: parsedJson['date'],
        time: parsedJson['time'],
        price: parsedJson['price']);
  }

  Future<List<Fixture>> loadFixtures(String fixJson) async {
    List<Fixture> fixtures = [];
    String myj =
        await rootBundle.loadString(fixJson); //'jsonfiles/today.json');
    List<dynamic> convJson = jsonDecode(myj);
    fixtures = convJson.map((f) => Fixture.fromJson(f)).toList();
    print(fixtures.length);
    return fixtures;
    //String teamA =myData[0]['teamA'];
    //return myData;
  }

  Future<List<Fixture>> loadFixturesOnline(var jsonUrl) async {
    List<Fixture> fixtures = [];
    var res =
        await http.get(jsonUrl, headers: {'Content-Type': 'application/json'});
    if (res.statusCode == 200) {
      List<dynamic> convJson = jsonDecode(res.body);
      fixtures = convJson.map((f) => Fixture.fromJson(f)).toList();
      print(fixtures.length);
      return fixtures;
    } else {
      // If that response was not OK, throw an error.
      //throw Exception('Failed to load post');
      print('Failed to load post');
      return fixtures;
    }
  }
}
