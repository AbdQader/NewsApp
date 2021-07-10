import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '/core/utils/components.dart';
import '/data/controllers/favorite_controller.dart';
import '/data/models/news.dart';
import '/views/screens/web_view_screen.dart';

class FavoriteItem extends StatelessWidget {
  
  final News news;
  final int? index;
  FavoriteItem(this.news, this.index);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => WebViewScreen(news)),
      child: GetBuilder<FavoriteController>(
        builder: (controller) => Dismissible(
          key: UniqueKey(), //Key('${news!.url}'),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            controller.removeNewsFromFavorite(news);
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
                  controller.addNewsToFavorite(news, index!);
                  Get.back();
                },
              )
            );
          },
          background: Container(
            padding: const EdgeInsets.only(right: 30),
            color: Colors.red,
            alignment: Alignment.centerRight,
            child: const Icon(Icons.delete, color: Colors.white, size: 40),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: news.urlToImage,
                    placeholder: (_, url) => Center(
                      child: showCircularProgress(),
                    ),
                    fit: BoxFit.cover,
                    height: 130.0,
                    width: 130.0,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 120.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            news.title,
                            style: Theme.of(context).textTheme.headline1,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                          ),
                        ),
                        Text(
                          news.publishedAt,
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