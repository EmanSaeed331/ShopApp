import 'package:flutter/material.dart';
import 'package:shopapp/moduls/shop_app_login/login_screen.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/shared/styles/components/components.dart';
class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:AppBar(
        title:Text(
          'Shopping',
          style: TextStyle(
            color:Colors.black,
          ),
        ),
      ),
    body:TextButton(
      onPressed:(){
        CacheHelper.removeData(key: 'token').then((value)
        {
          if (value){
            navigateAndFinish(context, LoginScreen());
          }
        });
      },
      child:Text(
        'Sign Out',
      ),
    ),
    );
  }
}
