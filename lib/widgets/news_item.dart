import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/news.dart';
import '../screens/web_view_screen.dart';

class NewsItem extends StatelessWidget {
  
  final News? news;
  NewsItem(this.news);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => WebViewScreen(news)),
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
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(10.0),
            //   child: Image.network(
            //     news!.urlToImage!,
            //     fit: BoxFit.cover,
            //     height: 130.0,
            //     width: 130.0,
            //   ),
            // ),

            // Container(
            //   width: 130.0,
            //   height: 130.0,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10.0),
            //     image: DecorationImage(
            //       image: NetworkImage(news!.urlToImage!),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
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
    );
  }
}