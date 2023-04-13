import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/CachHelper.dart';
import 'package:shop_app/modules/layout/home.dart';

import '../../rewidget.dart';
import '../register/registerSreen.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController EmailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  GlobalKey<FormState> FromKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginState>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModels.status == true) {
              print(state.loginModels.message);
              print(state.loginModels.data!.token);
              CachHelper.saveData(
                      key: 'token', value: state.loginModels.data!.token)
                  .then((value) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              });
            } else {
              print(state.loginModels.message);
              ShowToast(
                  message: state.loginModels.message!,
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
                          'Login',
                          style: TextStyle(
                            fontSize: 34,
                            color: Colors.black87,
                          ),
                        ),
                        const Text(
                          'Login now to brows our offers',
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
                            controller: EmailController,
                            type: TextInputType.emailAddress,
                            label: const Text('Email'),
                            prefix: const Icon(Icons.email),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter an email';
                              }
                            }),
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
                        state is! ShopLoginLoadingState
                            ? REButton(() {
                                if (FromKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: EmailController.text,
                                      password: PasswordController.text);
                                }
                              }, 'Login')
                            : const Center(
                                child: CircularProgressIndicator(),
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account'),
                            RETextButton(() {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(),
                                ),
                              );
                            }, 'Register from here'),
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
