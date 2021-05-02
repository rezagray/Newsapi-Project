/*Muhammad Reza Pahlepi(181420069)
Apriyo Fadli(181420091)
Arif Athallah(181420065)
Trima Subhan Perbawa(181420055)

Bagian Apriyo Fadli(181420091)
*/
import 'dart:convert';
import 'package:newsapi/model/newsmodel.dart';
import 'package:http/http.dart';

// Ini untuk mengabil data berdasarkan  top headline berdasarkan negara indonesia
class News {
  // ini dibuat untuk menjadi wadah JSON
  List<ArticleModel> datatobesavedin = [];

  Future<void> getNews() async {
    var url = Uri.parse(
        "http://newsapi.org/v2/top-headlines?country=id&apiKey=ba06ed0aa9334fad81e4c660a852a1fd");

    var response = await get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          // membuat model

          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            urlToImage: element['urlToImage'],
            description: element['description'],
            url: element['url'],
          );

          datatobesavedin.add(articleModel);
        }
      });
    }
  }
}

// Ini untuk mengambil data berdasarkan kategori di indonesia
class CategoryNews {
  List<ArticleModel> datatobesavedin = [];

  Future<void> getNews(String category) async {
    var urlcategory = Uri.parse(
        "http://newsapi.org/v2/top-headlines?country=id&category=$category&apiKey=ba06ed0aa9334fad81e4c660a852a1fd");

    var response = await get(urlcategory);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          // membuat model
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            urlToImage: element['urlToImage'],
            description: element['description'],
            url: element['url'],
          );

          datatobesavedin.add(articleModel);
        }
      });
    }
  }
}
