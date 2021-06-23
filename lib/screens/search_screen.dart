import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import '../models/news.dart';
import '../widgets/news_item.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsController>(
      init: NewsController(),
      builder: (controller) => Column(
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Search...',
                fillColor: Theme.of(context).focusColor,
                filled: true,
                prefixIcon: Icon(
                  Icons.search, 
                  color: Theme.of(context).hintColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(80),
                  borderSide: BorderSide.none
                ),
              ),
              onChanged: (value) => controller.searchForNews(value),
            ),
          ),
          Expanded(
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: controller.getSearchedNews.length,
              separatorBuilder: (context, index) => mDivider(context),
              itemBuilder: (BuildContext context, int index) {
                News news = controller.getSearchedNews[index];
                return NewsItem(news);
              },
            ),
          ),
        ],
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