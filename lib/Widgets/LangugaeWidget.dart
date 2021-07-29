
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LanguageWidget extends StatelessWidget {

  final String languageName;
  final String languageDenotation;
  final bool isSelected  ;

  const LanguageWidget({Key key, this.languageName, this.languageDenotation, this.isSelected = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isSelected ?  Container(

      height: 150,
      width: 150,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Card(

        elevation: 8.0,
        color: Colors.black54,

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.9),
              radius: 30.0,
              child: Container(

                child: Text(
                  languageDenotation,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            SizedBox(height: 24,),

            Container(


              child: Text(languageName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
            ),
          ],
        ),

      ),
    ) :  Container(

      height: 150,
      width: 150,
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Card(

        elevation: 4.0,
        color: Colors.white,

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            CircleAvatar(
              backgroundColor: Colors.black38,
              radius: 30.0,
              child: Container(

                child: Text(
                  languageDenotation,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            SizedBox(height: 24,),

            Container(


              child: Text(languageName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),),
            ),
          ],
        ),

      ),
    ) ;

  }
}
