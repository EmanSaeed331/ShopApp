import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/moduls/shop_app/cubit/cubit.dart';
import 'package:shopapp/moduls/shop_app/cubit/states.dart';
import 'package:shopapp/moduls/shop_app_login/login_screen.dart';
import 'package:shopapp/moduls/shop_app_search/search_screen.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/shared/styles/components/components.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Shopping',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions:[
              IconButton(icon:Icon(Icons.search),onPressed: (){
                navigateTo(context, SearchScreen());
              },)
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              onTap:(index){
                cubit.changeBottom(index);
              } ,
             currentIndex:  cubit.currentIndex,
              items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label:'Home',


            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.apps),
              label:'Category',

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label:'Favorite',

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label:'Settings',

            ),
          ]),

        );
      },
    );
  }
}
