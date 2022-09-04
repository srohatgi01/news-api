import 'package:flutter/material.dart';
import 'package:news_api/data/models/latest_news.dart';

import '../data/provider/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var fetchdata = NewsApi().fetchLatestNews();

  fetch() {
    setState(() {
      fetchdata = NewsApi().fetchLatestNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text("News App"),
      ),
      body: RefreshIndicator(
        onRefresh: () => fetch(),
        child: FutureBuilder(
          future: fetchdata,
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              LatestNews news = snapshot.data as LatestNews;
              return ListView.builder(
                itemCount: news.articles.length,
                itemBuilder: (context, index) => Card(
                  margin: const EdgeInsets.all(16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          news.articles[index].title!,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          news.articles[index].description!,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
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
      ),
    );
  }
}
