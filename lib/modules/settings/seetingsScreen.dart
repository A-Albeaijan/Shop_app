import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/CachHelper.dart';
import 'package:shop_app/cubit/cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/modules/loagin/loginScreen.dart';

import '../../rewidget.dart';

class SettingsScreen extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> FromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        //to display user data
        var model = ShopCubit.get(context).usermodel;
        nameController.text = model!.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return ShopCubit.get(context).usermodel != null
            ? Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Form(
                    key: FromKey,
                    child: Column(
                      children: [
                        state is ShopLoadingUpdateUserState
                            ? const LinearProgressIndicator()
                            : const SizedBox(
                                height: 30,
                              ),
                        REFormField(
                          obscureText: false,
                          controller: nameController,
                          type: TextInputType.text,
                          label: const Text('Name'),
                          prefix: const Icon(Icons.person),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Name must not be empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        REFormField(
                          obscureText: false,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: const Text('Email'),
                          prefix: const Icon(Icons.email),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Email must not be empty';
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        REFormField(
                          obscureText: false,
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: const Text('Phone'),
                          prefix: const Icon(Icons.phone),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Phone must not be empty';
                            }
                          },
                        ),
                        REButton(
                          () {
                            if (FromKey.currentState!.validate()) {
                              ShopCubit.get(context).updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                              );
                              ShowToast(
                                  message: 'Update has been done succ',
                                  ToastState: ToastState.SUCCESS);
                            } else {
                              ShowToast(
                                  message: 'Something went wrong',
                                  ToastState: ToastState.ERROR);
                            }
                          },
                          'Update',
                        ),
                        REButton(() {
                          CachHelper.removeData('token').then((value) {
                            if (value) {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            }
                          });
                        }, 'Logout')
                      ],
                    ),
                  ),
                ),
              )
            : const Center(child: CircularProgressIndicator());
      },
    );
  }
}
