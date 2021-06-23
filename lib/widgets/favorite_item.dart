import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/news_controller.dart';
import '../models/news.dart';
import '../screens/web_view_screen.dart';

class FavoriteItem extends StatelessWidget {
  
  final News? news;
  final int? index;
  FavoriteItem(this.news, this.index);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => WebViewScreen(news)),
      child: GetBuilder<NewsController>(
        init: NewsController(),
        builder: (controller) => Dismissible(
          key: UniqueKey(), //Key('${news!.title}'),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            controller.removeNewsFromFavorite(news!);
            Get.snackbar(
              'Article Removed',
              'Article removed successfully from favorites.',
              borderRadius: 0,
              margin: EdgeInsets.all(0),
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.grey[900],
              colorText: Colors.white,
              mainButton: TextButton(
                child: Text('Undo'),
                onPressed: () {
                  controller.addNewsToFavorite(news!, index!);
                  Get.back();
                },
              )
            );
          },
          background: Container(
            padding: EdgeInsets.only(right: 30),
            color: Colors.red,
            alignment: Alignment.centerRight,
            child: Icon(Icons.delete, color: Colors.white, size: 40),
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: news!.urlToImage!,
                    placeholder: (context, url) => Center(
                      child: SpinKitFadingCircle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    fit: BoxFit.cover,
                    height: 130.0,
                    width: 130.0,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 120.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            news!.title!,
                            style: Theme.of(context).textTheme.headline1,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                          ),
                        ),
                        Text(
                          news!.publishedAt!,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}