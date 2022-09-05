import 'package:flutter/material.dart';
import 'package:news_api/data/provider/api.dart';
import 'package:news_api/presentations/common_widgets/app_bar.dart';
import 'package:news_api/presentations/homepage.dart';

import '../data/models/latest_news.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String keyword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: 'Search Page'),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                onFieldSubmitted: (value) {
                  keyword = value;
                  setState(() {});
                },
                decoration: const InputDecoration(
                  hintText: 'Search Keywords',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            keyword.isEmpty
                ? Image.asset("assets/search.png")
                : FutureBuilder(
                    future:
                        keyword.isEmpty ? null : NewsApi().searchNews(keyword),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        NewsData newsData = snapshot.data as NewsData;
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: newsData.articles.length,
                          itemBuilder: (context, index) =>
                              CustomNewsCard(index: index, news: newsData),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return const Center(child: Text("Couldn't Load Data"));
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
