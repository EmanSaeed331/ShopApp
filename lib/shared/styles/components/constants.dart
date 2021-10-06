

import 'package:shopapp/moduls/shop_app_login/login_screen.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/shared/styles/components/components.dart';

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value)
  {
    if (value){
      navigateAndFinish(context, LoginScreen());
    }
  });
}
void printFullText (String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=> print(match.group(0)));
}
String token = '';