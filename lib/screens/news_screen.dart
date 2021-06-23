import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import '../models/news.dart';
import '../widgets/news_item.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsController>(
      init: NewsController(),
      builder: (controller) => controller.getNews.isEmpty
        ? Center(
          child: SpinKitFadingCircle(
            color: Theme.of(context).accentColor,
          ),
        )
        : ListView.separated(
          physics: BouncingScrollPhysics(),
          itemCount: controller.getNews.length,
          separatorBuilder: (context, index) => mDivider(context),
          itemBuilder: (BuildContext context, int index) {
            News news = controller.getNews[index];
            return NewsItem(news);
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