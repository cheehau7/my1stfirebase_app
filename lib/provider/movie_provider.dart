


import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myflutter_exp1/model/movie..dart';

final getFutureData = ChangeNotifierProvider<GetDataFromMovieApi>((ref) => GetDataFromMovieApi());

class GetDataFromMovieApi extends ChangeNotifier {
  dynamic listMovie;

  GetDataFromMovieApi() {
    listMovie = getData();
  }

  Future<List<Movie>> getMovieList () => getData();

  Future <List<Movie>> getData () async {
     final response = await http.get(Uri.parse('http://www.omdbapi.com/?s=Batman&page=2&apikey=564727fa'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["Search"];
      return list.map((e) => Movie.fromJson(e)).toList();
    }
    else {
      throw Exception('Unable to load data');
    }
  }

}