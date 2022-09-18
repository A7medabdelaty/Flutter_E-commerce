import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/model/categories_data_model.dart';
import 'package:shop_app/model/home_data_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ShopHomeScreen extends StatelessWidget {
  const ShopHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopCubitStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
          return ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.categoryModel != null,
            builder: (context) =>
                productBuilder(cubit.homeModel, cubit.categoryModel, cubit),
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  Widget productBuilder(HomeModel? model, CategoriesModel? categoriesModel,
          ShopCubit cubit) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CarouselSlider(
                items: model?.data?.banners
                    .map((e) => Image(
                          image: NetworkImage('${e.image}'),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: 250.0,
                  scrollDirection: Axis.horizontal,
                  autoPlay: true,
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  initialPage: 0,
                  viewportFraction: 1,
                  reverse: false,
                )),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => categoryItemBuilder(
                            categoriesModel!.data!.data![index]),
                        separatorBuilder: (context, index) => const SizedBox(
                              width: 10,
                            ),
                        itemCount: categoriesModel!.data!.data!.length),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  mySeparatorBuilder(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'New Products',
                    style: TextStyle(fontSize: 25),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                  childAspectRatio: 1 / 1.56,
                  crossAxisCount: 2,
                  children: List.generate(
                      model!.data!.products.length,
                      (index) => buildGridProduct(
                          model.data!.products[index], cubit))),
            ),
          ],
        ),
      );
}

Widget categoryItemBuilder(DataModel model) => Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage('${model.image}'),
          width: 100,
          height: 100,
        ),
        Container(
            width: 100,
            color: Colors.black.withOpacity(0.8),
            child: Text(
              '${model.name}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            )),
      ],
    );

Widget buildGridProduct(HomeProductsModel model, ShopCubit cubit) {
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(
                '${model.image}',
              ),
              width: double.infinity,
              height: 200,
            ),
            if (model.discount != 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                color: Colors.red,
                child: const Text('DISCOUNT',
                    style: TextStyle(color: Colors.white, fontSize: 10)),
              )
          ],
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  if (model.discount != 0)
                    Text('${model.oldPrice.round()}',
                        style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        )),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        cubit.changeFavorite(model.id!);
                      },
                      iconSize: 25,
                      icon: cubit.favoritesMap[model.id]!
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
      ],
    ),
  );
}
