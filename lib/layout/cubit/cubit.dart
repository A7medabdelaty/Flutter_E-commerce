import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/model/favorites_data_model.dart';
import 'package:shop_app/model/home_data_model.dart';
import 'package:shop_app/modules/categories_screen/categories_screen.dart';
import 'package:shop_app/modules/favorites_Screen/favorites_screen.dart';
import 'package:shop_app/modules/home_screen/home_screen.dart';
import 'package:shop_app/modules/settings_screen/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../model/categories_data_model.dart';
import '../../model/user_data_model.dart';

class ShopCubit extends Cubit<ShopCubitStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    const ShopHomeScreen(),
    const ShopFavoritesScreen(),
    const ShopCategoriesScreen(),
    ShopSettingsScreen(),
  ];

  void changeBottomNav(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favoritesMap = {};

  void getHomeData() {
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value?.data);
      homeModel?.data?.products.forEach((element) {
        favoritesMap.addAll({element.id!: element.inFavorites!});
      });
      emit(ShopHomeDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeDataErrorState());
    });
  }

  CategoriesModel? categoryModel;

  void getCategoriesData() {
    DioHelper.getData(url: CATEGORIES, token: token).then((value) {
      categoryModel = CategoriesModel.fromJson(value?.data);
      emit(ShopCategoriesDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoriesDataErrorState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavoritesData() {
    emit(ShopGetFavoritesLoadingState());
    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value?.data);
      emit(ShopGetFavoritesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetFavoritesErrorState());
    });
  }

  PostFavoritesModel? postModel;

  void changeFavorite(int? id) {
    favoritesMap[id!] = !favoritesMap[id]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(url: FAVORITES, data: {'product_id': id}, token: token)
        ?.then((value) {
      postModel = PostFavoritesModel.fromJson(value?.data);
      if (postModel?.status == false) {
        favoritesMap[id] = !favoritesMap[id]!;
        emit(ShopChangeFavoritesState());
      } else {
        getFavoritesData();
        emit(ShopChangeFavoritesSuccessState());
      }
    }).catchError((error) {
      emit(ShopChangeFavoritesErrorState());
    });
  }

  UserDataModel? userDataModel;

  void getUserData() {
    emit(ShopGetUserDataLoadingState());
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      userDataModel = UserDataModel.fromJson(value?.data);
      print(token);
      emit(ShopGetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopGetUserDataErrorState());
    });
  }

  void updateData(
      {required String name, required String email, required String phone}) {
    emit(ShopUpdateUserDataLoadingState());
    DioHelper.putData(url: UPDATE_PROFILE, data: {
      'name': name,
      'email': email,
      'phone': phone,
    },token: token).then((value) {
      userDataModel = UserDataModel.fromJson(value?.data);
      emit(ShopUpdateUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopUpdateUserDataErrorState());
    });
  }
}
