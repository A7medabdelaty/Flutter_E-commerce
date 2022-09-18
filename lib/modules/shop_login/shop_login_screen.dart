import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_layout_screen.dart';
import 'package:shop_app/modules/shop_login/login_cubit/login_cubit.dart';
import 'package:shop_app/modules/shop_login/login_cubit/login_states.dart';
import 'package:shop_app/modules/register_screen/shop_register_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../../shared/components/constants.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginCubitStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              if(state.model.status == true){
                CacheHelper.setData(key: 'token', value: state.model.data?.token).then((value){
                  token = state.model.data!.token!;
                });
                Fluttertoast.showToast(
                  msg: '${state.model.message}',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
                navigateAndReplace(context, ShopApp());
              }else{
                Fluttertoast.showToast(
                    msg: '${state.model.message}',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 5,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                );
              }
            }
          },
          builder: (context, state) {
            LoginCubit cubit = LoginCubit.get(context);
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Login now to browse our hot offers',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultInputField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          label: 'Email',
                          prefixIcon: Icons.email,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Email can not be empty';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultInputField(
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          label: 'Password',
                          obscureText: cubit.isPassword,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Password can not be empty';
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: Icons.lock,
                          suffixIcon: cubit.icon,
                          suffixAction: (){
                            cubit.changeVisibility();
                          }
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (BuildContext context) {
                            return defaultButton(
                                text: 'LOGIN',
                                radius: 7,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    LoginCubit.get(context).userLogin(
                                        email: emailController.text.toString(),
                                        password:
                                            passwordController.text.toString());
                                  }
                                });
                          },
                          fallback: (BuildContext context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text('Don\'t have an account?'),
                            TextButton(
                                onPressed: () {
                                  navigateTo(
                                      context, ShopRegisterScreen());
                                },
                                child: const Text('Register Now')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
