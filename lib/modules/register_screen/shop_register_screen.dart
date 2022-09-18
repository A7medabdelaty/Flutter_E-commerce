import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/register_screen/register_cubit/register_cubit.dart';
import 'package:shop_app/modules/register_screen/register_cubit/register_states.dart';
import 'package:shop_app/modules/shop_login/login_cubit/login_cubit.dart';
import 'package:shop_app/modules/shop_login/login_cubit/login_states.dart';
import 'package:shop_app/modules/shop_login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class ShopRegisterScreen extends StatelessWidget {
  ShopRegisterScreen({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (BuildContext context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterCubitStates>(
          listener: (context, state) {
            if (state is RegisterSuccessState) {
              if (state.model.status == true) {
                navigateAndReplace(context, ShopLoginScreen());
                Fluttertoast.showToast(
                  msg: '${state.model.message}',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
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
            RegisterCubit cubit = RegisterCubit.get(context);
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
                          'REGISTER',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Register now to join our community',
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defaultInputField(
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          label: 'Name',
                          prefixIcon: Icons.person,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Name can not be empty';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
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
                            suffixAction: () {
                              cubit.changeVisibility();
                            }),
                        const SizedBox(
                          height: 15,
                        ),
                        defaultInputField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          label: 'Phone',
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Phone can not be empty';
                            } else {
                              return null;
                            }
                          },
                          prefixIcon: Icons.phone,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (BuildContext context) {
                            return defaultButton(
                                text: 'REGISTER',
                                radius: 7,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.registerUser(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text);
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
