import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/shop_app/favorites_model.dart';
import 'package:shopapp/moduls/shop_app/cubit/cubit.dart';
import 'package:shopapp/moduls/shop_app/cubit/states.dart';
import 'package:shopapp/shared/styles/colors.dart';
import 'package:shopapp/shared/styles/components/components.dart';
class FavoritesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder:(context,state){
          return  ConditionalBuilder(
            condition: state is! ShopLoadingFavoritesState,
           builder: (context)  => ListView.separated(
             itemBuilder: (context,index) => buildFavItem(ShopCubit.get(context).favoritesModel.data.data[index],context),
             separatorBuilder: (context,index) =>myDivider(),
             itemCount: ShopCubit.get(context).favoritesModel.data.data.length, ),
            fallback:(context) =>Center(child: CircularProgressIndicator()),
          );
        }

    );
  }

  Widget buildFavItem (FavoritesData model,context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120.0,
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.product.image),
                width: 120.0,
              //  fit : BoxFit.cover,
                height: 120.0,
              ),
              if (model.product.discount!= 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                   'DISCOUNT',
                    style: TextStyle(fontSize: 8.0, color: Colors.white),
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      model.product.price.toString(),
                      style: TextStyle(
                        color: defaultColor,
                        fontSize: 12.0,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if (  model.product.discount != 0)
                      Text(
                        model.product.oldPrice.toString(),
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(model.product.id);
                         print(model.id);

                      },
                      icon: CircleAvatar(
                        backgroundColor:
                       ShopCubit.get(context).favorites[model.product.id]

                        ?defaultColor : Colors.grey ,
                        radius: 15,
                        child: Icon(
                          Icons.favorite_border,
                          size: 14.0,
                          color:Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
