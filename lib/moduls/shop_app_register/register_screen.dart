import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/shop_app/shop_layout.dart';
import 'package:shopapp/moduls/shop_app_login/cubit/cubit.dart';
import 'package:shopapp/moduls/shop_app_login/cubit/states.dart';
import 'package:shopapp/moduls/shop_app_register/cubit/cubit.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/shared/styles/components/components.dart';
import 'package:shopapp/shared/styles/components/constants.dart';

import 'cubit/states.dart';
class RegisterScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BlocContext) =>ShopRegisterCubit(),
      child:BlocConsumer<ShopRegisterCubit,RegisterStates>(
        listener: (context,state){
          if(state is ShopRegisterSuccessStates){

            if(state.loginModel.status){
              print(state.loginModel.message);
              print(state.loginModel.data.token);
              CacheHelper.saveData(key: 'token',value:state.loginModel.data.token).
              then((value) {
                token = state.loginModel.data.token;
                navigateAndFinish(context, ShopLayout());

              });

              showToast(
                text:state.loginModel.message,
                state:ToastStates.SUCCESS,

              );

            }
            else{
              print(state.loginModel.message);
              showToast(
                text:state.loginModel.message,
                state:ToastStates.ERROR,

              );

            }
          }

        },
        builder: (context,state){
          return  Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(),
            body : Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key : formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('REGISTER ',
                          style: Theme.of(context).textTheme.headline4.copyWith(
                            color:Colors.black,
                          ),
                        ),
                        Text('Register now to browse our hot offers',
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color:Colors.grey,
                          ),

                        ),
                        SizedBox(
                          height:30.0,

                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String value){
                            if(value.isEmpty){
                              return 'Please entrer your name address';
                            }
                          },
                          label: 'User Name ',
                          prefix: Icons.person,
                          // onSubmit: (value){
                          //   if(formKey.currentState.validate()){
                          //     ShopRegisterCubit.get(context).userLogin(
                          //       email: emailController.text,
                          //       password: passwordController.text,
                          //     );
                          //   }
                          // }
                        ),
                        SizedBox(
                          height:15.0,

                        ),
                        defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String value){
                              if(value.isEmpty){
                                return 'please entrer your email address';
                              }
                            },
                            label: 'Email address',
                            prefix: Icons.email_outlined,
                            onSubmit: (value){
                              if(formKey.currentState.validate()){
                                ShopRegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            }
                        ),
                        SizedBox(
                          height:15.0,

                        ),
                        defaultFormField(
                          isPassword: ShopRegisterCubit.get(context).isPassword,

                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          suffix: ShopRegisterCubit.get(context).suffix,
                          suffixPressed: (){
                            ShopRegisterCubit.get(context).changePasswordVisibility();
                          },
                          validate: (String value){
                            if(value.isEmpty){
                              return 'Password is too short ';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height:15.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,

                          validate: (String value){
                            if(value.isEmpty){
                              return 'Phone must not be empty  ';
                            }
                          },
                          label: 'Phone Number ',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height:15.0,

                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingStates,
                          builder: (context)=> defaultButton(
                            function: (){
                              if(formKey.currentState.validate()){
                                ShopRegisterCubit.get(context).userRegister(
                                  name : nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone : phoneController.text,
                                );
                              }
                            },
                            text: 'Register',
                            isUpperCase: true,
                          ),
                          fallback: (context)=>Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height:15.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),

    );
  }
}
