import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/model/search_data_model.dart';
import 'package:shop_app/modules/search_screen/search_cubit/search_cubit.dart';
import 'package:shop_app/modules/search_screen/search_cubit/search_states.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchCubit cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  if (state is SearchLoadingState) const LinearProgressIndicator(),
                  const SizedBox(height: 20,),
                  defaultInputField(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    label: 'Search',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'search can not be empty';
                      }
                      return null;
                    },
                    onSubmit: (value) {
                      cubit.search(value);
                    },
                    prefixIcon: Icons.search,
                  ),
                  if (state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) =>
                            searchItemBuilder(
                                cubit.searchModel?.data!.searchData[index],
                                cubit,
                                context),
                        itemCount: cubit.searchModel!.data!.searchData.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            mySeparatorBuilder(),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget searchItemBuilder(SearchData? model, SearchCubit cubit, context) =>
    Padding(
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
                    '${model?.image}',
                  ),
                  width: 120,
                  height: 120,
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model?.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model?.price}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              ShopCubit.get(context).changeFavorite(model?.id!);
                            },
                            iconSize: 25,
                            icon:
                                ShopCubit.get(context).favoritesMap[model?.id]!
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
