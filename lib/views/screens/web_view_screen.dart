import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '/data/controllers/favorite_controller.dart';
import '/core/utils/components.dart';
import '/data/models/news.dart';

class WebViewScreen extends StatelessWidget {
  
  final News news;
  WebViewScreen(this.news);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Article Detail',
          style: TextStyle(
            color: Get.theme.buttonColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(
          color: Get.theme.buttonColor,
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.more_vert, color: Get.theme.buttonColor),
            color: Get.theme.canvasColor,
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Open in Browser'), 
                value: 'openInBrowser',
              ),
            ],
            onSelected: (value) async {
              if (value == 'openInBrowser') {
                await canLaunch(news.url)
                  ? await launch(news.url)
                  : showSnackbar(
                     'Could not launch URL!', 
                     'May there is a problem with the URL.',
                    );
              }
            },
          ),
        ],
      ),
      body: WebView(
        initialUrl: news.url,
      ),
      floatingActionButton: GetBuilder<FavoriteController>(
        builder: (controller) => FloatingActionButton(
          onPressed: () {
            if (controller.getFavoritesUrls.contains(news.url)) {
              controller.removeNewsFromFavorite(news);
              showSnackbar('Article Removed', 'Article removed successfully from favorites.');
            } else {
              controller.addNewsToFavorite(news, 0);
              showSnackbar('Article Added', 'Article added successfully in favorites.');
            }
          },
          child: Icon(
            controller.getFavoritesUrls.contains(news.url)
            ? Icons.favorite
            : Icons.favorite_border
          ),
        ),
      ),
    );
  }
}
