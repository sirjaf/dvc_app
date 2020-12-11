import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class TopScorer {
  final String name;
  final String nationality;
  final String team;
  final String numberOfGoals;

  TopScorer(
    {
      this.name,this.nationality,this.team,this.numberOfGoals
    });

  factory TopScorer.fromJson(Map<String,dynamic> parsedJson){

       return TopScorer(
            name: parsedJson['player']['name'],
            nationality: parsedJson['player']['nationality'],
            team: parsedJson['team']['name'],
            numberOfGoals: parsedJson['numberOfGoals'].toString(), 
            );

  }  

   Future<List<TopScorer>> loadTable(String tableJson) async {
    List<TopScorer> topScorerList = [];
    String myj = await rootBundle.loadString(tableJson);//'jsonfiles/today.json');
    var convJson = jsonDecode(myj);
    List<dynamic> topScorer = convJson['scorers'];
    topScorerList = topScorer.map((f) => TopScorer.fromJson(f)).toList();
    print(topScorerList.length);
    return topScorerList;
    
  }

  Future<List<TopScorer>> loadTableOnline(var tableJson) async {

    List<TopScorer> topScorerList = [];
    var myj = await http.get(tableJson,headers: {'Content-Type':'application/json'});//'jsonfiles/today.json');

    if (myj.statusCode == 200){

    var convJson = jsonDecode(utf8.decode(myj.bodyBytes));
    List<dynamic> topScorer = convJson['scorers'];
    topScorerList = topScorer.map((f) => TopScorer.fromJson(f)).toList();
    print(topScorerList.length);
    return topScorerList;

    } else {

        return topScorerList;//throw Exception('Failed to load Top Scorers');
    }
    
  }

}