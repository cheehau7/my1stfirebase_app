import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myflutter_exp1/db_service.dart';
import 'package:myflutter_exp1/model/user.dart';

class UserProvider {
  final _fb = DBService().getFB;

  Future<User> fetchUser(String uuid) async {
    late final User usr;
    try {
      await _fb
          .child("userProfile/$uuid")
          .get()
          .then((DataSnapshot dataSnapshot) {
        if (dataSnapshot.exists) {
          //print(dataSnapshot.value);
          final response = Map<String, dynamic>.from(dataSnapshot.value);
          print("response: $response");
          if (response is Map) {
            print("True");
          }
          usr = User.fromJson(response);
          print("user : ${usr.name}");
          return usr;
        }
        else {
          throw Exception('unable');
        }
      });
    } on FirebaseException catch (e) {
      e.message;
    }
    return usr;
  }
}
