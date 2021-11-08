import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myflutter_exp1/db_service.dart';
import 'package:myflutter_exp1/model/love_movie.dart';
import 'package:myflutter_exp1/model/user.dart';
import 'package:myflutter_exp1/screen/movie_screen.dart';
import 'package:riverpod/riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myflutter_exp1/model/movie..dart';

final getFutureData =
    ChangeNotifierProvider<GetDataFromMovieApi>((ref) => GetDataFromMovieApi());
final _fb = DBService().getFB;

class GetDataFromMovieApi extends ChangeNotifier {
  List<FavMovie>? myMovie;
  final favMovie = _fb.child("/favMovie");
  bool _isFav = false;
  static List<FavMovie>? usrMovie;

  bool get myfav => _isFav;

  GetDataFromMovieApi() {
    //  listMovie = getData();
  }

  Future<List<Movie>> getMovieList() => getData();

  Future<List<Movie>> getData() async {
    final response = await http.get(
        Uri.parse('http://www.omdbapi.com/?s=Batman&page=2&apikey=564727fa'));
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["Search"];
      //print(list);
      return list.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception('Unable to load data');
    }
  }

  Future addFavMovie(FavMovie fm) async {
    try {
      await favMovie.child("${fm.uuid}/${fm.id}").update({
        'uuid': fm.uuid,
        'date_add': DateTime.now().toString()
      });
    } on FirebaseException catch (e) {
      print(e.toString());
    }
    finally {
      print("Success store movie like");
      
    }
  }

  Future<List<FavMovie>> fetchUserFavMovie(dynamic uuid) async {
    List<FavMovie> listMovie = <FavMovie>[];
    print("enter fetch user movie id $uuid");
    try {
      await favMovie.child("$uuid").get().then((value) {
            
            final mymovie = Map<String, dynamic>.from(value.value);
            var usrMovie = <String, dynamic>{};
            print("my movie:" + mymovie.toString());
            mymovie.forEach((key, value) {
                usrMovie['id'] = key;
                Map<String, dynamic>.from(value).forEach((key, value) {
                    usrMovie[key] = value;
                });
                listMovie.add(FavMovie.fromJson(usrMovie));
            });
          });
    }
    on FirebaseException catch (e) {
      print(e.toString());
    }
    print("listMOVIE $listMovie");
    myMovie = listMovie;
    return listMovie;
  }

}
