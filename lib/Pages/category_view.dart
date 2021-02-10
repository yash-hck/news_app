
import 'package:flutter/material.dart';
import 'package:newsapp/Models/article_model.dart';
import 'package:newsapp/Pages/article_view.dart';
import 'package:newsapp/helpers/News.dart';

class CategoreieView  extends StatefulWidget {

  final category;
  CategoreieView({this.category});

  @override
  _CategoreieViewState createState() => _CategoreieViewState();
}

class _CategoreieViewState extends State<CategoreieView > {

  bool _loading = true;
  List<ArticleModel> articles = [];

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
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: articles.length,
                scrollDirection: Axis.vertical,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context, index){
                  return BlogTile(imageUrl: articles[index].urltoImage, title: articles[index].title, desc: articles[index].description,url: articles[index].url,);
                },
              ),
            ),
          ),)
    );

  }
  getNews() async{
    News newsClass = News();
    await newsClass.getCategorieNews(this.widget.category);
    articles = newsClass.categoryNews;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getNews();
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
