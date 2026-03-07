import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/data/article.articals.model.dart';
import 'package:news_app/modules/repositary/repositary.dart';
// import 'package:news_app/network_handler/network_handler.dart';

part 'articals_state.dart';

class ArticalsCubit extends Cubit<ArticalsState> {
  final HomeRepositary _homeRepositary;
  ArticalsCubit(this._homeRepositary) : super(ArticalsInitial());

  List<Article>? _listArtical = [];

  Future<void> getArticals(String sourceId) async {
    try {
      emit(LoadingGetArtical());
      _listArtical = await _homeRepositary.getArtical(sourceId);
      emit(SuccessGetArtical(listArtical: _listArtical));
    } catch (e) {
      emit(ErrorGetArtical());
    }
  }
}
