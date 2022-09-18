import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class ShopSettingsScreen extends StatelessWidget {
  ShopSettingsScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopCubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        nameController.text = cubit.userDataModel!.data!.name!;
        emailController.text = cubit.userDataModel!.data!.email!;
        phoneController.text = cubit.userDataModel!.data!.phone!;
        return SingleChildScrollView(
          child: Column(
            children: [
              if (state is! ShopUpdateUserDataLoadingState)
                const SizedBox(height: 4,),
              if (state is ShopUpdateUserDataLoadingState)
                const LinearProgressIndicator(),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: CircleAvatar(
                          radius: 56,
                          backgroundColor: Colors.blue,
                          child: Container(
                            width: 110,
                            height: 110,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100)),
                            child: Image(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    '${cubit.userDataModel?.data?.image}')),
                          )),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          defaultInputField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            label: 'Name',
                            prefixIcon: Icons.person,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Name can not be empty';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          defaultInputField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            label: 'Email Address',
                            prefixIcon: Icons.email,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Email Address can not be empty';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          defaultInputField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            label: 'Phone',
                            prefixIcon: Icons.phone,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Phone can not be empty';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        defaultButton(
                            text: 'UPDATE',
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.updateData(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text);
                              }
                            },
                            width: 170,
                            radius: 15),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
