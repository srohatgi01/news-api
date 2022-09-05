import 'package:flutter/material.dart';
import 'package:news_api/data/models/latest_news.dart';
import 'package:news_api/presentations/common_widgets/app_bar.dart';
import 'package:news_api/presentations/common_widgets/custom_round_button.dart';

class ArticleDetails extends StatelessWidget {
  final Article article;
  final int articleIndex;
  const ArticleDetails(
      {Key? key, required this.article, required this.articleIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(text: 'News Details'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              article.urlToImage != null
                  ? Stack(children: [
                      Hero(
                          tag: 'articleImage$articleIndex',
                          child: Image.network(article.urlToImage!)),
                      article.source!.name != null
                          ? Positioned(
                              right: 0,
                              top: 150,
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  color: Colors.white,
                                  child: Text(article.source!.name!,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500))))
                          : Container(),
                    ])
                  : Container(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Text(
                      article.title!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          article.author != null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text('written by '),
                                    Expanded(
                                      child: Text('${article.author}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ],
                                )
                              : Container(),
                          article.publishedAt != null
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text('published at '),
                                    Text(
                                      article.publishedAt
                                          .toString()
                                          .split(' ')[0],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                )
                              : Container(),
                        ]),
                    const SizedBox(height: 10),
                    article.content != null
                        ? Text(
                            article.content!.split('[')[0],
                            style: const TextStyle(
                              // fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          )
                        : const Text("No content available for this news."),
                    const SizedBox(height: 10),
                    article.url != null
                        ? CustomRoundButton(
                            url: article.url!,
                            text: "View Article",
                          )
                        : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
