import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/model/search_data_model.dart';
import 'package:shop_app/modules/search_screen/search_cubit/search_states.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;

  void search(text) {
    emit(SearchLoadingState());
    DioHelper.postData(url: SEARCH, data: {'text': text}, token: token)
        ?.then((value) {
      searchModel = SearchModel.fromJson(value?.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
