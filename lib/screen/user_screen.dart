import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:myflutter_exp1/custom_bar.dart';
import 'package:myflutter_exp1/screen/second_screen.dart';


class UserScreen extends StatelessWidget {
  static const routeName = "/screen/user_screen.dart";
  final fb = FirebaseDatabase.instance;
  final myText = TextEditingController();
  final name = "Name";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Orientation deviceOrientation = MediaQuery.of(context).orientation;
    final ref = fb.reference();
    readData(ref);
    return Scaffold(
      appBar: CustomAppBar(title: "Test Screen"),
      key: _formKey,
      body: OrientationBuilder(builder: (context, orientation) {
        
          return LayoutBuilder(
            builder: (context, constraints) {
             
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            color: Colors.blue,
                            height: 110,
                            child: Center(
                              child: Text("Hew"),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Container(
                            color: Colors.yellowAccent,
                            height: 110,
                            child: Center(
                              child: Text("Hew"),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            color: Colors.greenAccent,
                            height: 110,
                            child: Center(
                              child: Text("Hew"),
                            ),
                          ),
                        ),
                        Flexible(
                            flex: 1,
                            child: Container(
                              color: Colors.indigoAccent,
                              height: 110,
                              child: Center(
                                child: Text("yes"),
                              ),
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: Container(
                              color: Colors.lightBlue, child: Text("Hew")),
                        ),
                        Flexible(
                          child: Container(
                              color: Colors.cyanAccent,
                              child: Text("Chee Hau")),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                              color: Colors.lightBlue, child: Text("Hew")),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(
                              color: Colors.cyanAccent,
                              child: Text("Chee Hau")),
                        )
                      ],
                    ),
                    Expanded(
                      child: TextField(
                        
                        controller: myText,
                        textInputAction: TextInputAction.none,
                        keyboardType: TextInputType.text,
                        
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => updateData(ref),
                      child: Text('Update'),
                    ),
                    ElevatedButton(
                      onPressed: () => deleteData(ref),
                      child: Text('Delete'),
                    )
                   
                  ],
                );
              }
            
          );
        }
      ),
    );
  }

  void readData(DatabaseReference dr) {
      dr.once().then((DataSnapshot snapshot) {
          print('Data: ${snapshot.value}');
      });
  }

  void updateData(DatabaseReference dr) {
    print("Updating...");
    dr.child('name').update({
        'description' : 'IVAN'
    });
  }

  void deleteData(DatabaseReference dr) {
    dr.remove();
  }
}



class MyFlowDeletgate implements FlowDelegate {
  @override
  void pathChildren(FlowPaintingContext ctx) {}

  @override
  bool shouldRepaint(MyFlowDeletgate old) {
    return false;
  }

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    // TODO: implement getConstraintsForChild
    throw UnimplementedError();
  }

  @override
  Size getSize(BoxConstraints constraints) {
    // TODO: implement getSize
    throw UnimplementedError();
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // TODO: implement paintChildren
  }

  @override
  bool shouldRelayout(covariant FlowDelegate oldDelegate) {
    // TODO: implement shouldRelayout
    throw UnimplementedError();
  }
}
