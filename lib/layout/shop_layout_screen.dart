import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/search_screen/shop_search_screen.dart';

import '../shared/components/components.dart';

class ShopApp extends StatelessWidget {
  ShopApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopCubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('salla'),
            actions: [
              IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  }),
              if (cubit.currentIndex == 3)
                IconButton(
                    onPressed: () {
                      Logout(context);
                    },
                    icon: Icon(Icons.logout)),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                cubit.changeBottomNav(value);
              },
              currentIndex: cubit.currentIndex,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'Favorites'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps), label: 'Categories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ]),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
