import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/data/article.articals.model.dart';
import 'package:news_app/models/data/data.articals.model.dart';
import 'package:news_app/models/source_data_model.dart';
import 'package:news_app/network_handler/api_constance.dart';
import 'package:news_app/network_handler/end_points.dart';

class NetworkHandler {
  static Future<List<SourceData>> getSources(String categoryId) async {
    try {
      Map<String, dynamic> queryParametars = {
        "apiKey": ApiConstance.apiKey,
        "category": categoryId,
      };
      var response = await http.get(
        Uri.https(ApiConstance.baseUrl, EndPoints.allSources, queryParametars),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        SourceDataModel sourceDataModel = SourceDataModel.fromJson(data);
        return sourceDataModel.sources;
      } else {
        throw Exception("some thing went wrong");
      }
    } catch (e) {
      throw Exception("some thing went wrong");
    }
  }

  static Future<List<Article>?> getArtical(String sourceId) async {
    try {
      Map<String, dynamic> queryParametar = {
        "apiKey": ApiConstance.apiKey,
        "sources": sourceId,
      };
      var resposce = await http.get(
        Uri.http(ApiConstance.baseUrl, EndPoints.allArticals, queryParametar),
      );
      // List<Data> articalDataList = [];
      if (resposce.statusCode == 200) {
        var data = jsonDecode(resposce.body);
        var myData = Data.fromJson(data);
        return myData.articles;

        // for (var element in data["articles"]) {
        //   var myData = Data.fromJson(element);
        //   articalDataList.add(myData);
        // }
        // return articalDataList;
      } else {
        throw Exception("something went wrong");
      }
    } catch (e) {
      throw Exception("something went wrong");
    }
  }
}
