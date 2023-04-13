import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/dio_helper.dart';
import 'package:shop_app/modules/loagin/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/register/cubit/state.dart';

import '../../../ednpoint.dart';

import '../../../models/loginModels.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  LoginModels? RegisterModel;

  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: register,
      data: {
        'email': email,
        'password': password,
        'phone': phone,
        'name': name,
      },
    ).then((value) {
      print(value.data);
      RegisterModel = LoginModels.fromJson(value.data);

      emit(ShopRegisterSuccessState(RegisterModel!));
    }).catchError((error) {
      print('Error ${error} ----');
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool PasswordShow = true;
  void ChangePasswordVisibility() {
    PasswordShow = !PasswordShow;
    suffix = PasswordShow
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());
  }
}
