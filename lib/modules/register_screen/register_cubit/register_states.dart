import 'package:shop_app/model/shop_login_model.dart';

abstract class RegisterCubitStates {}

class RegisterInitialState extends RegisterCubitStates {}

class RegisterLoadingState extends RegisterCubitStates {}

class RegisterSuccessState extends RegisterCubitStates {
  ShopLoginModel model;

  RegisterSuccessState(this.model);
}

class RegisterErrorState extends RegisterCubitStates {}

class RegisterChangeVisibilityState extends RegisterCubitStates {}
