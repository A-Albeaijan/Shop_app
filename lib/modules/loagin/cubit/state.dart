import '../../../models/loginModels.dart';

abstract class ShopLoginState {}

class ShopLoginInitialState extends ShopLoginState {}

class ShopLoginLoadingState extends ShopLoginState {}

class ShopLoginSuccessState extends ShopLoginState {
  final LoginModels loginModels;
  ShopLoginSuccessState(this.loginModels);
}

class ShopLoginErrorState extends ShopLoginState {
  final String error;

  ShopLoginErrorState(this.error);
}

class ShopLoginChangePasswordVisibilityState extends ShopLoginState {}
