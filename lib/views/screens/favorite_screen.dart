import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/utils/components.dart';
import '/data/controllers/favorite_controller.dart';
import '/data/models/news.dart';
import '/views/widgets/favorite_item.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoriteController>(
      builder: (controller) => 
      controller.isLoading
        ? Center(child: showCircularProgress())
        : controller.getFavoritesNews.isEmpty
            ? buildFavoritesEmpty(context)
            : ListView.separated(
                physics: BouncingScrollPhysics(),
                itemCount: controller.getFavoritesNews.length,
                separatorBuilder: (_, index) => customDivider(),
                itemBuilder: (_, index) {
                  News news = controller.getFavoritesNews[index];
                  return FavoriteItem(news, index);
                },
              ),
    );
  }

  // This function to build an empty widget for favorites
  Widget buildFavoritesEmpty(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_outlined,
            size: 130,
            color: Theme.of(context).buttonColor,
          ),
          const SizedBox(height: 30),
          Text(
            'Your favorites are empty !',
            style: TextStyle(
              color: Theme.of(context).buttonColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )
    );
  }

}