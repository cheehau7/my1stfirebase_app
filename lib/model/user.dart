import 'package:myflutter_exp1/model/love_movie.dart';

class User {
  final String? name;
  final int? age;
  final String? email;
  final String? uuid;
  final String? image;
  final List<FavMovie>? favmovie;

  User({this.name, this.age, this.email, this.uuid, this.image, this.favmovie});

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? "",
        age = int.tryParse(json['age'] ?? "0") ?? 0,
        email = json['email'] ?? "",
        uuid = json['uuid'] ?? "",
        image = json['image'] ?? "",
        favmovie = json['favmovie'];
  //User.second({required this.name, required this.age});
  

}
