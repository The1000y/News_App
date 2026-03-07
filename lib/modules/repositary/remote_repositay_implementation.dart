import 'package:news_app/models/data/article.articals.model.dart';
import 'package:news_app/models/source_data_model.dart';
import 'package:news_app/modules/repositary/repositary.dart';
import 'package:news_app/network_handler/network_handler.dart';

class RemoteHomeRepositaryImplementation implements HomeRepositary {
  @override
  Future<List<Article>?> getArtical(String sourceId) async {
    return await NetworkHandler.getArtical(sourceId);
  }

  @override
  Future<List<SourceData>> getSources(String categoryId) async {
    return await NetworkHandler.getSources(categoryId);
  }
}
