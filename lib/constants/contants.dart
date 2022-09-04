abstract class Constants {}

class Api extends Constants {
  final String _apiKey = "dda4fc112b8a445aadba97bc87fccc0c";
  get getApiKey => _apiKey;
}

class ApiLatestNewsUrl extends Constants {
  final String _baseUrl =
      "https://newsapi.org/v2/top-headlines?country=us&pageSize=10&apiKey=";

  get getLatestNewsUrl => _baseUrl + Api().getApiKey;
}
