import 'article.articals.model.dart';

class Data {
  String? status;
  int? totalResults;
  List<Artical>? articles;

  Data({this.status, this.totalResults, this.articles});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      status: json['status'] as String?,
      totalResults: json['totalResults'] as int?,
      articles: (json['articles'] as List<dynamic>?)
          ?.map((e) => Artical.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalResults': totalResults,
      'articles': articles?.map((e) => e.toJson()).toList(),
    };
  }
}
