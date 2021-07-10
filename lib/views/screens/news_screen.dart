import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/utils/components.dart';
import '/data/controllers/news_controller.dart';
import '/data/models/news.dart';
import '/views/widgets/news_item.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsController>(
      builder: (controller) => controller.isLoading
      ? Center(child: showCircularProgress())
      : controller.getNews.isEmpty
          ? buildNewsError(context)
          : ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: controller.getNews.length,
              separatorBuilder: (_, index) => customDivider(),
              itemBuilder: (_, index) {
                News news = controller.getNews[index];
                return NewsItem(news);
              },
            ),
    );
  }

  // This function builds a widget that explains an error that occurred
  Widget buildNewsError(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Something went wrong !',
            style: TextStyle(
              color: Theme.of(context).buttonColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Please check your connection.',
            style: TextStyle(
              color: Theme.of(context).buttonColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 30),
          Get.find<NewsController>().isPressed
            ? showCircularProgress()
            : ElevatedButton(
                onPressed: () {
                  Get.find<NewsController>().onPressed();
                  Get.find<NewsController>().fetchNews();
                },
                child: Text(
                  'Try again',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
        ],
      ),
    );
  }

}