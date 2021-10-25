import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:myflutter_exp1/authentication.dart';
import 'package:myflutter_exp1/model/user.dart';
import 'package:myflutter_exp1/screen/landing_screen.dart';
import 'package:myflutter_exp1/screen/login_screen.dart';

enum Status {
  SignedIn,
  SignOut,
  Registering,
}

final fb = FirebaseDatabase.instance.reference();
String? uuid;
String? name;
int? loginTimes;
var data;
var daily;


class AuthProvider with ChangeNotifier {
    bool _passwordVisible = false;
    bool get passwordVisible => _passwordVisible;
    Future<bool> checkLogin() async {
    bool isSigned = false;
    await AuthenticationHelper().getUser().then((result) => {
          if (result == null)
            {print("result is null"), isSigned = false}
          else
            {
              print("result got"),
              isSigned = true,
              uuid = result,
            }
        });
    if (uuid != null) {
      var retrieveData = [];
      var readData = fb.orderByChild("uuid").equalTo(uuid);
      readData
          .once()
          .then((DataSnapshot dataSnapshot) => {
            
          //  data = Map<String, dynamic>.from(dataSnapshot.value),
            
          });
    }
    return isSigned;
   
    }
  Future updateSignInTime() async {
    
  }

 passwordVisibility() {
    _passwordVisible = !_passwordVisible;

    notifyListeners();
  }

    
}
