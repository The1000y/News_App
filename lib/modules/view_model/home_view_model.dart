import 'package:flutter/material.dart';
import 'package:news_app/models/data/article.articals.model.dart';
import 'package:news_app/models/source_data_model.dart';
import 'package:news_app/network_handler/network_handler.dart';

class HomeViewModel extends ChangeNotifier {
  int _selectedTapIndex = 0;
  int get selectedTapIndex => _selectedTapIndex;

  onTap(int index) {
    _selectedTapIndex = index;
    getArticals(_listData[index].id);
    notifyListeners();
  }

  List<SourceData> _listData = [];

  List<SourceData> get listData => _listData;

  Future<void> getSources(String categoryId) async {
    try {
      _listData = await NetworkHandler.getSources(categoryId);
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  List<Article>? _listArtical = [];

  List<Article>? get listArtical => _listArtical;

  Future<void> getArticals(String sourceId) async {
    try {
      _listArtical = await NetworkHandler.getArtical(sourceId);
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }
}
