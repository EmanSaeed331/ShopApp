import 'package:shopapp/models/shop_app/login_model.dart';

abstract class LoginStates {}

class ShopLoginIntialStates extends LoginStates{}
class ShopLoginLoadingStates extends LoginStates{}
class ShopLoginSuccessStates extends LoginStates{
  final ShopLoginModel loginModel ;

  ShopLoginSuccessStates(this.loginModel);
}
class ShopLoginErrorStates extends LoginStates{
  final String error;
  ShopLoginErrorStates(this.error);
}
class ShopLoginChangePasswordVisibilityState extends LoginStates{}
