import '../../../models/loginModels.dart';

abstract class ShopRegisterState {}

class ShopRegisterInitialState extends ShopRegisterState {}

class ShopRegisterLoadingState extends ShopRegisterState {}

class ShopRegisterSuccessState extends ShopRegisterState {
  final LoginModels RegisterModels;
  ShopRegisterSuccessState(this.RegisterModels);
}

class ShopRegisterErrorState extends ShopRegisterState {
  final String error;

  ShopRegisterErrorState(this.error);
}

class ShopRegisterChangePasswordVisibilityState extends ShopRegisterState {}
