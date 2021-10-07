import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/BlocObserver.dart';
import 'package:shopapp/layout/shop_app/shop_layout.dart';
import 'package:shopapp/moduls/shop_app/cubit/cubit.dart';
import 'package:shopapp/moduls/shop_app/cubit/states.dart';
import 'package:shopapp/moduls/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:shopapp/moduls/shop_app_login/login_screen.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
import 'package:shopapp/shared/styles/colors.dart';
import 'package:shopapp/shared/styles/components/constants.dart';

Future<void> main() async {
 // bool onBoarding = false;
  Widget widget;

  //make sure that every method applied then open the application
 WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  DioHelper.init();
  await CacheHelper.init();
  bool onBoarding = CacheHelper.getData(key:'onBoarding');
  token = CacheHelper.getData(key:'token');
  print('TOKEEEEN'+token);
  if(onBoarding !=null){
    if(token  !=null) widget = ShopLayout();
    else widget = LoginScreen();


  }
  else{
    widget = OnBoardingScreen();
  }
  print('onboarding__${onBoarding}');
  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final  Widget startWidget;
  MyApp({this.startWidget});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiBlocProvider(
      providers:[
        BlocProvider(
            create:( context) => ShopCubit()..getHomeData()..getCategories()..getFavorites(),
        ),
      ],
      child:BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder:(context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: defaultColor,
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  unselectedItemColor:Colors.grey,
                  selectedItemColor: defaultColor,
                  elevation: 10,
                  backgroundColor: Colors.white,
                type: BottomNavigationBarType.fixed,
              ),
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


              fontFamily: 'Jannah',
            ),

            home:startWidget,

          );
        },

      ),
    );
  }
}
