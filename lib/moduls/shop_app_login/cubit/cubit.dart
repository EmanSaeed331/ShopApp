import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/moduls/shop_app_login/cubit/states.dart';
import 'package:shopapp/shared/network/local/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<LoginStates>{
  ShopLoginCubit():super(ShopLoginIntialStates());
  static ShopLoginCubit get(context)=>BlocProvider.of(context);

  void userLogin({
  @required String email,
  @required String password,
})
  {
    emit(ShopLoginLoadingStates());
    DioHelper.postData(url: LOGIN,
        data:{
          'email':email,
          'password':password,
        }
    ).then((value){
      print(value.data);
      emit(ShopLoginSuccessStates());
    }).catchError((error){
      emit(ShopLoginErrorStates(error.toString()));
      print("error----"+error.toString());
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true ;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined :  Icons.visibility_off_outlined;
    emit(ShopLoginChangePasswordVisibilityState());


  }
}