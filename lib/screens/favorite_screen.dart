import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import '../models/news.dart';
import '../widgets/favorite_item.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsController>(
      init: NewsController(),
      builder: (controller) => controller.getFavoritesNews.isEmpty
        ? Center(
          child: Text(
            'Your favorites articles is empty !!',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          )
        )
        : ListView.separated(
          physics: BouncingScrollPhysics(),
          itemCount: controller.getFavoritesNews.length,
          separatorBuilder: (context, index) => mDivider(context),
          itemBuilder: (BuildContext context, int index) {
            News news = controller.getFavoritesNews[index];
            return FavoriteItem(news, index);
          },
        ),
    );
  }

  Widget mDivider(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Divider(color: Theme.of(context).dividerColor),
    );
  }

}