import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/model/categories_data_model.dart';

import '../../shared/components/components.dart';

class ShopCategoriesScreen extends StatelessWidget {
  const ShopCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopCubitStates>(builder: (context, state) {
      ShopCubit cubit = ShopCubit.get(context);
      return ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
          categoryBuilder(cubit.categoryModel?.data?.data?[index]),
          separatorBuilder: (context, index) => mySeparatorBuilder(),
          itemCount: cubit.categoryModel!.data!.data!.length);
    }, listener: (context, state) {},);
  }
}

Widget categoryBuilder(DataModel? categoryModel) => Padding(
  padding: const EdgeInsets.all(10.0),
  child: Row(
    children: [
      Image(
        image: NetworkImage(
            '${categoryModel?.image}'),
        width: 80,
        height: 80,
      ),
      const SizedBox(
        width: 15,
      ),
      Text(
        '${categoryModel?.name}',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const Spacer(),
      const Icon(Icons.arrow_forward_ios),
    ],
  ),
);
