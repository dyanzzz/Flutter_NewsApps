import 'package:dicoding_news_app/common/styles.dart';
import 'package:dicoding_news_app/data/api/api_service.dart';
import 'package:dicoding_news_app/data/model/api_article.dart';
import 'package:dicoding_news_app/data/model/article.dart';
import 'package:dicoding_news_app/widgets/card_article.dart';
import 'package:dicoding_news_app/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'article_detail_page.dart';

class ArticleListPage extends StatefulWidget {
  static const routeName = '/article_list';

  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  Future<ApiArticle> _article;
  @override
  void initState() {
    _article = ApiService().topHeadlines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('News App Ios'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder(
      future: _article,
      builder: (context, AsyncSnapshot<ApiArticle> snapshot) {
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.articles.length,
              itemBuilder: (context, index) {
                var article = snapshot.data.articles[index];
                return CardArticle(
                  article: article,
                  onPressed: () => Navigator.pushNamed(
                      context, ArticleDetailPage.routeName,
                      arguments: article),
                );
              });
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          return Text("");
        }
      },
    );
  }
/*
  Widget _buildArticleItem(BuildContext context, Article article) {
    return Material(
        color: primaryColor,
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          leading: Hero(
            tag: article.urlToImage,
            child: Image.network(
              article.urlToImage,
              width: 100,
            ),
          ),
          title: Text(article.title),
          subtitle: Text(article.author),
          onTap: () {
            Navigator.pushNamed(context, ArticleDetailPage.routeName,
                arguments: article);
          },
        ));
  }
  */
}
