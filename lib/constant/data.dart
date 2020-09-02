import 'package:dio/dio.dart';
import 'package:news/constant/endpoint.dart';

Future getVideoData() async {
//  Map<String, dynamic> data;
  Response response;
  try {
    response = await Dio().get(Endpoint.latestVideo,
        queryParameters: {"per_page": 10, "page": 1});
//    data = response.data;
    print(' Category.. DATA : >> ${response.data[0]['date']}');
  } catch (e) {
    print(e);
  }
  return response;
}

Future getSearchData(String key) async {
//  Map<String, dynamic> data;
  Response response;
  try {
    response = await Dio().get(Endpoint.searchPost, queryParameters: {
      "per_page": 10,
      "page": 1,
      "order": "asc",
      "search": key
    });
//    data = response.data;
    print(' Category.. DATA : >> ${response.data[0]['date']}');
  } catch (e) {
    print(e);
  }
  return response;
}

Future getHomeData(int index) async {
//  Map<String, dynamic> data;
  Response response;
  try {
    response = await Dio().get(Endpoint.category,
        queryParameters: {"categories": index, "per_page": 10, "page": 1});
//    data = response.data;
    print(' Category.. DATA : >> ${response.data[0]['date']}');
  } catch (e) {
    print(e);
  }
  return response;
}
