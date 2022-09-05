import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:news_api/data/models/latest_news.dart';

class ArticleDetails extends StatelessWidget {
  final Article article;
  final int articleIndex;
  const ArticleDetails(
      {Key? key, required this.article, required this.articleIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Article Details"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
                tag: 'articleImage$articleIndex',
                child: Image.network(article.urlToImage!)),
            const SizedBox(height: 10),
            Text(
              article.title!,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
