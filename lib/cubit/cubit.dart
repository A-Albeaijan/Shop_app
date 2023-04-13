import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/dio_helper.dart';
import 'package:shop_app/models/categoriesModel.dart';
import 'package:shop_app/models/favoritesModel.dart';
import 'package:shop_app/models/getfacoriteModel.dart';
import 'package:shop_app/models/homeModel.dart';
import 'package:shop_app/models/loginModels.dart';
import 'package:shop_app/modules/categoryes/categoryScreen.dart';
import 'package:shop_app/modules/favorites/favoritScreen.dart';
import 'package:shop_app/modules/product/productScreen.dart';
import 'package:shop_app/modules/settings/seetingsScreen.dart';

import '../CachHelper.dart';
import '../ednpoint.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitiakState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> BottomScreen = [
    PrdocutScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];
  void ChangeBottmo(int index) {
    currentIndex = index;
    emit(ShopChangeBottmNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favoriteList = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: Home,
      token: CachHelper.getData('token'),
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products.forEach(
        (element) {
          favoriteList.addAll({element['id']: element['in_favorites']});
        },
      );

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print('Error at ShopErrorHomeDataState ${error}');
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories() {
    DioHelper.getData(
      url: categories,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      print('Error at ShopErrorCategoriesDataState ${error}');
      emit(ShopErrorCategoriesDataState());
    });
  }

  FavoritesModel? favoritesmodel;

  void changefavorites(int id) {
    if (favoriteList[id] == true) {
      favoriteList[id] = false;
    } else {
      favoriteList[id] = true;
    }
    emit(ShopChangeFavoritesDataState());
    DioHelper.postData(
      url: favorites,
      data: {
        'product_id': id,
      },
      token: CachHelper.getData('token'),
    ).then((value) {
      favoritesmodel = FavoritesModel.fromJson(value.data);
      print(value.data);
      print(CachHelper.getData('token'));
      if (favoritesmodel!.status == false) {
        if (favoriteList[id] == true) {
          favoriteList[id] = false;
        } else {
          favoriteList[id] = true;
        }
      } else {
        getFavorit();
      }
      emit(ShopSuccessChangeFavoritesDataState(favoritesmodel!));
    }).catchError((error) {
      if (favoriteList[id] == true) {
        favoriteList[id] = false;
      } else {
        favoriteList[id] = true;
      }
      emit(ShopErrorChangeFavoritesDataState());
    });
  }

  GetFavoritModel? getFavoritModel;
  void getFavorit() {
    emit(ShopLoadingGetFavoriteState());
    DioHelper.getData(
      url: favorites,
      token: CachHelper.getData('token'),
    ).then((value) {
      getFavoritModel = GetFavoritModel.fromJson(value.data);

      emit(ShopSuccessGetFavoriteState());
    }).catchError((error) {
      print('Error at ShopErrorGetFavoriteState ${error}');
      emit(ShopErrorGetFavoriteState());
    });
  }

  LoginModels? usermodel;
  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: profile,
      token: CachHelper.getData('token'),
    ).then((value) {
      usermodel = LoginModels.fromJson(value.data);
      print(usermodel!.data!.name);
      emit(ShopSuccessUserDataState(usermodel!));
    }).catchError((error) {
      print('Error at ShopErrorUserDataState ${error}');
      emit(ShopErrorUserDataState());
    });
  }

  void updateUserData(
      {required String name, required String email, required String phone}) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: update_profile,
      token: CachHelper.getData('token'),
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      usermodel = LoginModels.fromJson(value.data);
      print(usermodel!.data!.name);
      emit(ShopSuccessUpdateUserState(usermodel!));
    }).catchError((error) {
      print('Error at ShopErrorUpdateUserState ${error}');
      emit(ShopErrorUpdateUserState());
    });
  }
}
