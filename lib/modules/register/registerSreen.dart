import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/loagin/loginScreen.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/state.dart';

import '../../CachHelper.dart';
import '../../models/loginModels.dart';
import '../../rewidget.dart';
import '../layout/home.dart';
import '../loagin/cubit/cubit.dart';
import '../loagin/cubit/state.dart';

class RegisterScreen extends StatelessWidget {
  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  TextEditingController NameController = TextEditingController();

  GlobalKey<FormState> FromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterState>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.RegisterModels.status == true) {
              print(state.RegisterModels.message);
              print(state.RegisterModels.data!.token);
              CachHelper.saveData(
                      key: 'token', value: state.RegisterModels.data!.token)
                  .then((value) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              });
            } else {
              print(state.RegisterModels.message);
              ShowToast(
                  message: state.RegisterModels.message!,
                  ToastState: ToastState.ERROR);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: FromKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 34,
                            color: Colors.black87,
                          ),
                        ),
                        const Text(
                          'Register now to brows our offers',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        REFormField(
                          obscureText: false,
                          controller: NameController,
                          type: TextInputType.text,
                          label: const Text('Username'),
                          prefix: const Icon(Icons.person),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a username';
                            }
                          },
                        ),
                        REFormField(
                          obscureText: false,
                          controller: EmailController,
                          type: TextInputType.emailAddress,
                          label: const Text('Email'),
                          prefix: const Icon(Icons.email),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter an email';
                            }
                          },
                        ),
                        REFormField(
                          obscureText: false,
                          controller: PhoneController,
                          type: TextInputType.phone,
                          label: const Text('Phone'),
                          prefix: const Icon(Icons.phone),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a phone number';
                            }
                          },
                        ),
                        REFormField(
                          suffix: const Icon(Icons.visibility_outlined),
                          controller: PasswordController,
                          type: TextInputType.visiblePassword,
                          label: const Text('Password'),
                          prefix: const Icon(Icons.lock),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a password';
                            }
                          },
                          obscureText: true,
                        ),
                        state is! ShopRegisterLoadingState
                            ? REButton(() {
                                if (FromKey.currentState!.validate()) {
                                  ShopRegisterCubit.get(context).userRegister(
                                      email: EmailController.text,
                                      password: PasswordController.text,
                                      name: NameController.text,
                                      phone: PhoneController.text);
                                }
                              }, 'Register')
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('have an account'),
                            RETextButton(() {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            }, 'Login from here'),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
