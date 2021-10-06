import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/shop_app/categories_model.dart';
import 'package:shopapp/models/shop_app/home_model.dart';
import 'package:shopapp/moduls/shop_app/cubit/states.dart';
import 'package:shopapp/moduls/shop_app_categories/categories_screen.dart';
import 'package:shopapp/moduls/shop_app_favorite/favorites_screen.dart';
import 'package:shopapp/moduls/shop_app_login/login_screen.dart';
import 'package:shopapp/moduls/shop_app_products/products_screen.dart';
import 'package:shopapp/moduls/shop_app_settings/settings_screen.dart';
import 'package:shopapp/shared/network/local/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
import 'package:shopapp/shared/styles/components/constants.dart';

class ShopCubit extends Cubit <ShopStates>
{
  ShopCubit() : super(ShopIntialState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List <Widget> bottomScreens = [
    ProdcutsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  void changeBottom(int index){
    currentIndex = index ;
    emit(ShopChangeBottomNavState());
  }
  HomeModel homeModel;
  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
        url:HOME,
        token:token,
    ).then((value)
      {
      homeModel = HomeModel.fromJson(value.data);
      printFullText(homeModel.data.banners[0].image);
      printFullText(homeModel.status.toString());
      printFullText(homeModel.toString());
      emit(ShopSuccessHomeDataState());

    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());


    });

  }

  CategoriesModel categoriesModel;
  void getCategories()
  {
    DioHelper.getData(
      url:GET_CATEGORIES,
      token:token,
    ).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());

    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesState());


    });

  }

}