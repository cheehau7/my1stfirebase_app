
import 'package:myflutter_exp1/provider/auth_provider.dart';
import 'package:myflutter_exp1/screen/movie_detail.dart';

class FavMovie {
  
  final String? uuid;
  final String id;
  //final String title;
  final String date_add;
  static bool cache = false;
  static FavMovie? favMovieStatic;
  FavMovie({this.uuid,  required this.date_add, required this.id});

  factory FavMovie.fromJson(Map<String, dynamic> json) {
    print("added favmovie");
    return FavMovie(uuid: json['uuid'], id: json['id'], date_add: json['date_add']); 
  }

  
}