import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/shop_login_model.dart';
import 'package:shop_app/modules/register_screen/register_cubit/register_states.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../shared/components/components.dart';
import '../../shop_login/shop_login_screen.dart';

class RegisterCubit extends Cubit<RegisterCubitStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? model;

  void registerUser(
      {required name, required email, required password, required phone}) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: REGISTER, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone
    })?.then((value) {
      model = ShopLoginModel.fromJson(value?.data);
      emit(RegisterSuccessState(model!));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState());
    });
  }

  bool isPassword = true;
  IconData icon = Icons.visibility;

  void changeVisibility() {
    isPassword = !isPassword;
    icon = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(RegisterChangeVisibilityState());
  }
}
