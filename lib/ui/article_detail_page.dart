import 'package:dicoding_news_app/common/navigation.dart';
import 'package:dicoding_news_app/data/model/article.dart';
import 'package:dicoding_news_app/ui/article_web_view.dart';
import 'package:flutter/material.dart';

class ArticleDetailPage extends StatelessWidget {
  static const routeName = '/article_detail';
  final Article article;
  const ArticleDetailPage({@required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            article.urlToImage == null
                ? Container(
                    height: 200,
                    child: Icon(Icons.error),
                  )
                : Hero(
                    tag: article.urlToImage,
                    child: Image.network(article.urlToImage)),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(article.description ?? ""),
                  Divider(color: Colors.grey),
                  Text(
                    article.title ?? "",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Text('Date : ${article.publishedAt}'),
                  SizedBox(height: 10),
                  Text('Author : ${article.author}'),
                  Divider(
                    color: Colors.grey,
                  ),
                  Text(
                    article.content ?? "",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  RaisedButton(
                    child: Text('Read more'),
                    onPressed: () {
                      //code
                      Navigation.intentWithData(
                          ArticleWebView.routeName, article.url);
                      /*Navigator.pushNamed(context, ArticleWebView.routeName,
                          arguments: article.url);*/
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
