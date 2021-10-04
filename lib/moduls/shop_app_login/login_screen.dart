import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/layout/shop_app/shop_layout.dart';
import 'package:shopapp/moduls/shop_app_login/cubit/cubit.dart';
import 'package:shopapp/moduls/shop_app_login/cubit/states.dart';
import 'package:shopapp/moduls/shop_app_register/register_screen.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/shared/styles/components/components.dart';
class LoginScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passwordController = TextEditingController();


    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,LoginStates>(
        listener: (context,state){
          if(state is ShopLoginSuccessStates){

            if(state.loginModel.status){
              print(state.loginModel.message);
              print(state.loginModel.data.token);
              CacheHelper.saveData(key: 'token',value:state.loginModel.data.token).
              then((value) {
                navigateAndFinish(context, ShopLayout(),);
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
          return Scaffold(
            backgroundColor: Colors.white,
            appBar:AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key : formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LOGIN',
                        style: Theme.of(context).textTheme.headline4.copyWith(
                          color:Colors.black,
                        ),
                      ),
                      Text('Login now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color:Colors.grey,
                        ),

                      ),
                      SizedBox(
                        height:30.0,

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
                            ShopLoginCubit.get(context).userLogin(
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
                        isPassword: ShopLoginCubit.get(context).isPassword,

                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        suffix: ShopLoginCubit.get(context).suffix,
                        suffixPressed: (){
                          ShopLoginCubit.get(context).changePasswordVisibility();
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
                        height:30.0,

                      ),
                      ConditionalBuilder(
                        condition: state is! ShopLoginLoadingStates,
                        builder: (context)=> defaultButton(
                          function: (){
                            if(formKey.currentState.validate()){
                              ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                              );
                            }

                          },
                          text: 'Login',
                          isUpperCase: true,
                        ),
                        fallback: (context)=>Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height:15.0,

                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Don\'t have an account?',
                          ),
                          defaultTextButton(
                            function: (){
                              navigateAndFinish(context, RegisterScreen(),);

                            },
                            text: 'register',
                          ),
                        ],
                      ),

                    ],

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
