import 'package:flutter/material.dart';
import 'package:news_api/data/models/latest_news.dart';
import 'package:news_api/presentations/article_details.dart';

import '../data/provider/api.dart';
import 'common_widgets/app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var fetchdata = NewsApi().fetchNewsData();

  fetch() async {
    print("Fetched called");
    setState(() {
      fetchdata = NewsApi().fetchNewsData();
      print("Data Fetched");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: 'News App'),
      body: FutureBuilder(
        future: fetchdata,
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            NewsData news = snapshot.data as NewsData;
            return RefreshIndicator(
              onRefresh: () => fetch(),
              child: ListView.builder(
                itemCount: news.articles.length,
                itemBuilder: (context, index) =>
                    CustomNewsCard(news: news, index: index),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class CustomNewsCard extends StatelessWidget {
  const CustomNewsCard({
    Key? key,
    required this.news,
    required this.index,
  }) : super(key: key);

  final NewsData news;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: (() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleDetails(
                article: news.articles[index],
                articleIndex: index,
              ),
            ),
          );
        }),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              news.articles[index].urlToImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Hero(
                          tag: 'articleImage$index',
                          child:
                              Image.network(news.articles[index].urlToImage!)),
                    )
                  : Container(),
              const SizedBox(height: 10),
              Text(
                news.articles[index].title!,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 10),
              news.articles[index].description != null
                  ? Text(
                      news.articles[index].description!,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : const Text(''),
            ],
          ),
        ),
      ),
    );
  }
}
