import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/model/favorites_data_model.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../shared/styles/colors.dart';

class ShopFavoritesScreen extends StatelessWidget {
  const ShopFavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopCubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return ConditionalBuilder(
          condition: state is! ShopGetFavoritesLoadingState,
          builder: (context) => ListView.separated(
              itemBuilder: (context, index) => favoriteItemBuilder(
                  cubit.favoritesModel!.dataModel!.data![index], cubit),
              separatorBuilder: (context, index) =>
                  mySeparatorBuilder(startSpace: 12),
              itemCount: cubit.favoritesModel!.dataModel!.data!.length),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget favoriteItemBuilder(FavoritesData model, ShopCubit cubit) => Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    '${model.product?.image}',
                  ),
                  width: 120,
                  height: 120,
                ),
                if (model.product!.discount != 0)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    color: Colors.red,
                    child: const Text('DISCOUNT',
                        style: TextStyle(color: Colors.white, fontSize: 10)),
                  )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.product!.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.product!.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        if (model.product!.discount != 0)
                          Text('${model.product!.oldPrice}',
                              style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              )),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              cubit.changeFavorite(model.product!.id!);
                            },
                            iconSize: 25,
                            icon: cubit.favoritesMap[model.product?.id]!
                                ? const Icon(
                                    Icons.favorite,
                                    color: mainColor,
                                  )
                                : const Icon(Icons.favorite_border)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
