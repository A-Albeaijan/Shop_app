import 'package:shop_app/models/favoritesModel.dart';
import 'package:shop_app/models/loginModels.dart';

abstract class ShopStates {}

class ShopInitiakState extends ShopStates {}

class ShopChangeBottmNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesDataState extends ShopStates {}

class ShopErrorCategoriesDataState extends ShopStates {}

class ShopChangeFavoritesDataState extends ShopStates {}

class ShopSuccessChangeFavoritesDataState extends ShopStates {
  final FavoritesModel model;

  ShopSuccessChangeFavoritesDataState(this.model);
}

class ShopErrorChangeFavoritesDataState extends ShopStates {}

class ShopLoadingGetFavoriteState extends ShopStates {}

class ShopSuccessGetFavoriteState extends ShopStates {}

class ShopErrorGetFavoriteState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates {
  final LoginModels model;

  ShopSuccessUserDataState(this.model);
}

class ShopErrorUserDataState extends ShopStates {}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {
  final LoginModels model;

  ShopSuccessUpdateUserState(this.model);
}

class ShopErrorUpdateUserState extends ShopStates {}
