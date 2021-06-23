import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controllers/news_controller.dart';
import '../models/news.dart';

class WebViewScreen extends StatelessWidget {
  
  final News? news;
  WebViewScreen(this.news);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Article Detail',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: WebView(
        initialUrl: news!.url,
        onProgress: (progress) => SpinKitFadingCircle(
          color: Theme.of(context).accentColor,
        ),
      ),
      floatingActionButton: GetBuilder<NewsController>(
        init: NewsController(),
        builder: (controller) => FloatingActionButton(
          onPressed: () {
            if (controller.getFavoritesUrls.contains(news!.url)) {
              controller.removeNewsFromFavorite(news!);
              Get.snackbar(
                'Article Removed',
                'Article removed successfully from favorites.',
                borderRadius: 0,
                margin: EdgeInsets.all(0),
                backgroundColor: Colors.grey[900],
                colorText: Colors.white,
              );
            } else {
              controller.addNewsToFavorite(news!, 0);
              Get.snackbar(
                'Article Added',
                'Article added successfully in favorites.',
                borderRadius: 0,
                margin: EdgeInsets.all(0),
                backgroundColor: Colors.grey[900],
                colorText: Colors.white,
              );
            }
          },
          child: Icon(
            controller.getFavoritesUrls.contains(news!.url)
            ? Icons.favorite
            : Icons.favorite_border
          ),
        ),
      ),
    );
  }
}
