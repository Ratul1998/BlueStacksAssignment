import 'package:bluestack_assignment/Config/KeyStrings.dart';
import 'package:bluestack_assignment/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{


  GlobalKey<ScaffoldState> scaffoldKey;

  String appBarTitle;

  MyAppBar({this.scaffoldKey,this.appBarTitle});

  Size get preferredSize => new Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {

    return AppBar(

      centerTitle: true,
      title: Text(getTranslated(context, appBarTitle), textAlign: TextAlign.center, style: TextStyle(color: Colors.black),),
      backgroundColor: Colors.white, elevation: 0.0,
      leading: IconButton(
        icon: Image.asset('assets/images/nav_bar_icon.png', height: 12,),
        onPressed: () {
          scaffoldKey.currentState.openDrawer();
        },

      ),
    );

  }

}