import 'package:bluestack_assignment/Config/KeyStrings.dart';
import 'package:bluestack_assignment/Widgets/LangugaeWidget.dart';
import 'package:bluestack_assignment/localization/language_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';

class LanguageScreen extends StatefulWidget {

  bool forLogin;

  LanguageScreen({this.forLogin = false});

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {


  bool isJapaneseSelected = false ;
  bool isEnglishSelected = false;

  Locale locale;

  @override
  void initState()  {
    super.initState();


    getLocale().then((locale) {
      setState(() {
        this.locale = locale;
      });
    }).then((value) {
      if(locale.languageCode == "en") {
        isEnglishSelected = true;
        isJapaneseSelected = false;
      }else if(locale.languageCode == "ja"){
        isEnglishSelected = false;
        isJapaneseSelected = true;
      }
    });

  }

  void _changeLanguage(String languageCode) async {
    Locale _locale = await setLocale(languageCode);
    MyApp.setLocale(context, _locale);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(getTranslated(context, KeyStrings.changeLanguage)),
        backgroundColor: Colors.black54,

      ),

      body: Container(

        height: double.infinity,

        child: Column(
          children: [

            SizedBox(height: 24,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(

                  onTap: () {
                    setState(() {
                      isEnglishSelected = true;
                      isJapaneseSelected = false;
                      _changeLanguage("en");

                    });
                  },
                  child: LanguageWidget(
                    languageDenotation: "A",
                    languageName: "English",
                    isSelected: isEnglishSelected,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isEnglishSelected = false;
                      isJapaneseSelected = true;
                      _changeLanguage("ja");
                    });
                  },
                  child: LanguageWidget(
                    languageDenotation: "ア",
                    languageName: "Japanese",
                    isSelected:  isJapaneseSelected,
                  ),
                ),
              ],
            ),


          ],
        ),
      ),

      /*floatingActionButton: (widget.forLogin) ?FloatingActionButton.extended(onPressed: (){

        Navigator.of(context).push(MaterialPageRoute(

            builder: (BuildContext context) => Login()));


      }, label: Text('Continue')) : null,*/

    );
  }
}
