import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/shop_app/search_model.dart';
import 'package:shopapp/moduls/shop_app_search/cubit/states.dart';
import 'package:shopapp/shared/network/local/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';
import 'package:shopapp/shared/styles/components/constants.dart';

class SearchCubit extends Cubit<SearchState>{
  SearchCubit(): super(SearchIntialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel model;

  void search (String text)
  {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      token: token,
      data:
      {
      'text':text,

    }).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());

    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());

    });
    
  }

}