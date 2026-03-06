import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/source_data_model.dart';
import 'package:news_app/modules/all_cubits/articals_cubit/articals_cubit.dart';
import 'package:news_app/modules/all_cubits/sources_cubit/sources_state.dart';
import 'package:news_app/network_handler/network_handler.dart';

class SourcesCubit extends Cubit<SourcesState> {
  SourcesCubit(this.articalsCubit) : super(HomeInitialState());

  final ArticalsCubit articalsCubit;

  int _selectedTapIndex = 0;
  int get selectedTapIndex => _selectedTapIndex;

  List<SourceData> _listSources = [];
  List<SourceData> get listSources => _listSources;

  onTap(int index) {
    _selectedTapIndex = index;
    articalsCubit.getArticals(_listSources[index].id);
    emit(changeIndexState());
  }

  Future<void> getSources(String categoryId) async {
    try {
      emit(LoadingGetAllSources());
      _listSources = await NetworkHandler.getSources(categoryId);
      emit(SuccessGetAllSources(listSources: _listSources));
    } catch (e) {
      emit(ErrorGetAllSources());
      // throw Exception(e);
    }
  }
}
