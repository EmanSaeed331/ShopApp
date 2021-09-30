abstract class LoginStates {}

class ShopLoginIntialStates extends LoginStates{}
class ShopLoginLoadingStates extends LoginStates{}
class ShopLoginSuccessStates extends LoginStates{}
class ShopLoginErrorStates extends LoginStates{
  final String error;
  ShopLoginErrorStates(this.error);
}
class ShopLoginChangePasswordVisibilityState extends LoginStates{}
