import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newsapp/Models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> news = [];
  List<ArticleModel> categoryNews = [];

  getNews()async{
    String url = 'https://newsapi.org/v2/top-headlines?country=in&apiKey=43f0eb807d8145e9862f6a525b80f51e';

    var respons = await http.get(url);

    var jsonData = jsonDecode(respons.body);
    print(jsonData['status'].toString());
    if(jsonData['status'] == "ok"){
      jsonData['articles'].forEach((element){

        if(element['urlToImage']!=null && element['description'] != null){

          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            description: element['description'],
            author: element['author'],
            urltoImage: element['urlToImage'],
            url: element["url"],
            context: element['context'],
            //publishedAt: element['publishedAt']
          );
          news.add(articleModel);
        }
      });
    }

  }

  getCategorieNews(category)async{

    String url = 'https://newsapi.org/v2/top-headlines?country=de&category=$category&apiKey=43f0eb807d8145e9862f6a525b80f51e';

    var respons = await http.get(url);

    var jsonData = jsonDecode(respons.body);
    print(jsonData['status'].toString());
    if(jsonData['status'] == "ok"){
      jsonData['articles'].forEach((element){

        if(element['urlToImage']!=null && element['description'] != null){

          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            description: element['description'],
            author: element['author'],
            urltoImage: element['urlToImage'],
            url: element["url"],
            context: element['context'],
            //publishedAt: element['publishedAt']
          );
          categoryNews.add(articleModel);
        }
      });
    }

  }

}
