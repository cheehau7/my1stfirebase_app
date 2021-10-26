import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';

class FireStorageService {

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref('images/person.png');

  static Future<dynamic>? loadImage(BuildContext context, String image) async { 
    return await firebase_storage.FirebaseStorage.instance.ref('images/men.png').getDownloadURL();
  }

}