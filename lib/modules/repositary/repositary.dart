import 'package:news_app/models/data/article.articals.model.dart';
import 'package:news_app/models/source_data_model.dart';

abstract class HomeRepositary {
  Future<List<SourceData>> getSources(String categoryId);
  Future<List<Article>?> getArtical(String sourceId);
}
