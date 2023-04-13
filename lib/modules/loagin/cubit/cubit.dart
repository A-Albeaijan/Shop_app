import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/dio_helper.dart';
import 'package:shop_app/modules/loagin/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../ednpoint.dart';
import '../../../models/loginModels.dart';

class ShopLoginCubit extends Cubit<ShopLoginState> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  LoginModels? loginModel;

  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: Login,
      data: {'email': email, 'password': password},
    ).then((value) {
      print(value.data);
      loginModel = LoginModels.fromJson(value.data);

      emit(ShopLoginSuccessState(loginModel!));
    }).catchError((error) {
      print('Error ${error} ----');
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool PasswordShow = true;
  void ChangePasswordVisibility() {
    PasswordShow = !PasswordShow;
    suffix = PasswordShow
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ShopLoginChangePasswordVisibilityState());
  }
}
