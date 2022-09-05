import "package:http/http.dart" as http;
import 'package:news_api/constants/contants.dart';
import 'package:news_api/data/models/latest_news.dart';

class NewsApi {
  Future<NewsData> fetchNewsData() async {
    http.Response response = await http.get(
      Uri.parse(ApiLatestNewsUrl().getLatestNewsUrl),
    );
    print("Latest News API request, OK");

    if (response.statusCode == 200) {
      NewsData news = newsDataFromJson(response.body);
      return news;
    } else {
      throw Exception('Failed to load news Data');
    }
  }

  Future<NewsData> searchNews(String keyword) async {
    http.Response response = await http.get(
      Uri.parse(ApiSearchNewsUrl().getSearchNewsUrl + keyword),
    );

    print("Search News API request, OK");

    if (response.statusCode == 200) {
      NewsData news = newsDataFromJson(response.body);
      return news;
    } else {
      throw Exception('Failed to load news Data');
    }
  }
}
