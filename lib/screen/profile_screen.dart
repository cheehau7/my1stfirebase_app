import 'package:flutter/material.dart';


class ProfileScreen extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, cts) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.purple, Colors.indigo]
                  )
                ),
              
              ),
              Container(
               
                margin: EdgeInsets.only(top: cts.maxHeight * 0.2),
                height: cts.maxHeight * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(cts.maxHeight * 0.10),
                    topRight: Radius.circular(cts.maxHeight * 0.10)
                  )
                ),
                
              ),

            ],
          );
        },
      ),
    );
  }
}