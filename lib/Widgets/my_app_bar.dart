import 'package:bluestack_assignment/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{


  GlobalKey<ScaffoldState> scaffoldKey;

  String appBarTitle;

  MyAppBar({this.scaffoldKey,this.appBarTitle});

  Size get preferredSize => new Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {

    return AppBar(

      centerTitle: true,
      title: Text(getTranslated(context, appBarTitle), textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline3,),
      elevation: 0.0,
      leading: IconButton(
        icon: Image.asset('assets/images/nav_bar_icon.png', height: 12, color: Theme.of(context).iconTheme.color,),
        onPressed: () {
          scaffoldKey.currentState.openDrawer();
        },

      ),
    );

  }

}