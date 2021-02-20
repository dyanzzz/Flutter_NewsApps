import 'package:dicoding_news_app/common/styles.dart';
import 'package:dicoding_news_app/data/api/api_service.dart';
import 'package:dicoding_news_app/data/model/api_article.dart';
import 'package:dicoding_news_app/data/model/article.dart';
import 'package:dicoding_news_app/provider/news_provider.dart';
import 'package:dicoding_news_app/widgets/card_article.dart';
import 'package:dicoding_news_app/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      backgroundColor: darkPrimaryColor,
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
    return Consumer<NewsProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.articles.length,
            itemBuilder: (context, index) {
              var article = state.result.articles[index];
              return CardArticle(
                article: article,
                onPressed: () => Navigator.pushNamed(
                  context,
                  ArticleDetailPage.routeName,
                  arguments: article,
                ),
              );
            },
          );
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(''));
        }
      },
    );
    /*
    return SingleChildScrollView(
      child: Column(
        children: [
          RaisedButton(
            child: Text("Refresh"),
            onPressed: () {
              setState(() {
                _article = ApiService().topHeadlines();
              });
            },
          ),
          FutureBuilder(
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
          )
        ],
      ),
    );*/
  }
}
