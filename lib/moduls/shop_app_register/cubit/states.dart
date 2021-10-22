import 'package:shopapp/models/shop_app/login_model.dart';

abstract class RegisterStates {}

class ShopRegisterIntialStates extends RegisterStates{}

class ShopRegisterLoadingStates extends RegisterStates{}

class ShopRegisterSuccessStates extends RegisterStates{

  final ShopLoginModel loginModel ;

  ShopRegisterSuccessStates(this.loginModel);

}

class ShopRegisterErrorStates extends RegisterStates{

  final String error;

  ShopRegisterErrorStates(this.error);

}

class ShopRegisterChangePasswordVisibilityState extends RegisterStates{}

