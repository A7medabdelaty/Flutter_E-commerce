import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc_observer.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/modules/shop_login/shop_login_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'layout/shop_layout_screen.dart';
import 'modules/on_boarding_screen/on_boarding_screen.dart';
import 'shared/network/remote/dio_helper.dart';

Widget myScreen = const OnBoardingScreen();

void chooseMainScreen() {
  bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
  token = CacheHelper.getData(key: 'token') ?? '';
  if (onBoarding == true) {
    myScreen = ShopLoginScreen();
  }
  if (token.length > 1) {
    myScreen = ShopApp();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  chooseMainScreen();

  BlocOverrides.runZoned(
    () {
      // Use cubits...
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getFavoritesData()..getHomeData()..getCategoriesData()..getUserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: lightTheme,
        darkTheme: darkTheme,
        home: myScreen,
      ),
    );
  }
}
