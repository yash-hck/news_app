import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {

  final String url;


  ArticleView({this.url});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
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
            ),
          actions: [
            Opacity(
              opacity: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.save),
              ),
            )
          ],
        ),
        body: Container(
        child: WebView(
          initialUrl: this.widget.url,
          onWebViewCreated: ((WebViewController webViewController){
            _controller.complete(webViewController);
          }),
        ),
    ),
      );
  }
}
