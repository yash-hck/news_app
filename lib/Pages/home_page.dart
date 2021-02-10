
import 'dart:convert';
import 'package:http/http.dart' as http;


import 'package:flutter/material.dart';
import 'package:newsapp/Models/article_model.dart';
import 'package:newsapp/Models/categorymodel.dart';
import 'package:newsapp/Pages/article_view.dart';
import 'package:newsapp/Pages/category_view.dart';
import 'package:newsapp/helpers/News.dart';
import 'package:newsapp/helpers/data.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<CategoryModel> categories = [];
  List<ArticleModel> articles = [];
  bool _loading = true;
  List<ArticleModel> news = [];

  Future<void> getNews()async{
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
          articles.add(articleModel);
        }
      });
    }
    setState(() {
      _loading = false;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('INDIA',
              style: TextStyle(
                color: Colors.black
              ),
              ),
            Text('times',
              style: TextStyle(
                color: Colors.blueAccent
              ),

            )
          ],
        )
      ),
      body: SafeArea(
        child : _loading? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ):
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: RefreshIndicator(
          onRefresh: getdata,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: articles.length + 1,
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            itemBuilder: (context, index){
              if(index == 0)
                return Container(

                  height: 70,
                  child: ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return CategoryTile(categoryName: categories[index].categoryName,imageUrl: categories[index].imageUrl);
                    },
                  ),
                );
              return BlogTile(imageUrl: articles[index-1].urltoImage, title: articles[index-1].title, desc: articles[index-1].description,url: articles[index-1].url,);
            },
          ),
        ),
      ),)
    );
  }



  Future<void> getdata() async{
    setState(() {
      articles.clear();
      getNews();
    });


  }

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }
}

class CategoryTile extends StatelessWidget {

  final String imageUrl, categoryName;


  CategoryTile({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>CategoreieView(category: categoryName.toLowerCase())));
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(imageUrl: imageUrl,width: 120,height: 60,fit: BoxFit.cover,)),
            Container(
              alignment: Alignment.center,
              width: 120,height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),

              child: Text(categoryName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w500
              ),),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {

  final String imageUrl, title, desc,url;


  BlogTile({@required this.imageUrl,@required this.title,@required this.desc,@required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>ArticleView(
          url: url,
        )));
      },
      child: Container(

        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl),
            ),

            SizedBox(height: 8),
            Text(title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black87
            ),),
            SizedBox(height: 4),
            Text(desc,
            style: TextStyle(
              color: Colors.grey
            ),),
            SizedBox(height: 5,)
          ],
        ),
      ),
    );
  }
}

