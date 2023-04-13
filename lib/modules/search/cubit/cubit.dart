import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/dio_helper.dart';
import 'package:shop_app/modules/search/cubit/state.dart';

import '../../../CachHelper.dart';
import '../../../ednpoint.dart';
import '../../../models/searchModel.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchmodel;

  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      token: CachHelper.getData('token'),
      url: products_search,
      data: {
        'text': text,
      },
    ).then((value) {
      searchmodel = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState());
      print('error at SearchErrorState ${error}');
    });
  }
}
