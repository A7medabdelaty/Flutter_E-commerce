import 'package:shop_app/model/shop_login_model.dart';

abstract class LoginCubitStates {}

class LoginInitialState extends LoginCubitStates {}

class LoginLoadingState extends LoginCubitStates {}

class LoginSuccessState extends LoginCubitStates {
  ShopLoginModel model;

  LoginSuccessState(this.model);
}

class LoginErrorState extends LoginCubitStates {}

class LoginChangeVisibilityState extends LoginCubitStates {}
