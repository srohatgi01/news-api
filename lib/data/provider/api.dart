import 'dart:developer';

import "package:http/http.dart" as http;
import 'package:news_api/constants/contants.dart';
import 'package:news_api/data/models/latest_news.dart';

class NewsApi {
  Future<LatestNews> fetchLatestNews() async {
    http.Response response = await http.get(
      Uri.parse(ApiLatestNewsUrl().getLatestNewsUrl),
    );
    print("Latest News API request, OK");

    if (response.statusCode == 200) {
      LatestNews news = latestNewsFromJson(response.body);
      return news;
    } else {
      throw Exception('Failed to load news Data');
    }
  }
}
