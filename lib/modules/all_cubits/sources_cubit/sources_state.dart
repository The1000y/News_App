import 'package:news_app/models/source_data_model.dart';

sealed class SourcesState {}

class HomeInitialState extends SourcesState {}

//GetAllSources
class SuccessGetAllSources extends SourcesState {
  List<SourceData> listSources = [];

  SuccessGetAllSources({required this.listSources});
}

class ErrorGetAllSources extends SourcesState {
  ErrorGetAllSources();
}

class LoadingGetAllSources extends SourcesState {
  LoadingGetAllSources();
}

//getArtical

class changeIndexState extends SourcesState {
  changeIndexState();
}
