import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopapp/moduls/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:shopapp/shared/styles/colors.dart';

void main ()
{

  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:OnBoardingScreen(),
      theme:ThemeData(
        primarySwatch: defaultColor,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        fontFamily:'Jannah',

      ),
    );
  }


}