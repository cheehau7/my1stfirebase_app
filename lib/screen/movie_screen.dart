import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myflutter_exp1/model/movie..dart';
import 'package:http/http.dart' as http;




class MovieScreen extends StatelessWidget {
 
  final List<Movie> _movies = <Movie>[];
  
  void _populateAllMovies() async {
  final movies = await _fetchAllMovies();
  
  }

  Future<List<Movie>> _fetchAllMovies() async {
    final response = await http.get(Uri.parse("http://www.omdbapi.com/?s=Batman&page=2&apikey=564727fa"));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["Search"];
      return list.map((e) => Movie.fromJson(e)).toList();

    }
    else {
      throw Exception("Failed to load movies.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _movies.length,
      itemBuilder: (context, index) {
        final movie = _movies[index];

        return ListTile(
          title: Row(
            children: [
              SizedBox(
                width: 100,
                child: ClipRRect(
                  child: Image.network(movie.poster ?? ""),
                  borderRadius: BorderRadius.circular(10),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}