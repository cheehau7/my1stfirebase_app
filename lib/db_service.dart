

import 'package:firebase_database/firebase_database.dart';

class DBService {

  final _fb = FirebaseDatabase.instance.reference();
  static final DBService _dbService = DBService._internal();
  factory DBService() => _dbService;
  DBService._internal();
  
  DatabaseReference get getFB => _fb;
 

  

}