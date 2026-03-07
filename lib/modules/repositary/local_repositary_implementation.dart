import 'package:news_app/models/data/article.articals.model.dart';
import 'package:news_app/models/source_data_model.dart';
import 'package:news_app/modules/repositary/repositary.dart';

class LocalRepositaryImplementation implements HomeRepositary {
  @override
  Future<List<Article>?> getArtical(String sourceId) {
    // TODO: implement getArtical
    throw UnimplementedError();
  }

  @override
  Future<List<SourceData>> getSources(String categoryId) {
    // TODO: implement getSources
    throw UnimplementedError();
  }
}
