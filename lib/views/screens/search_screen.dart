import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/core/utils/components.dart';
import '/data/controllers/search_controller.dart';
import '/data/models/news.dart';
import '/views/widgets/news_item.dart';

class SearchScreen extends StatelessWidget {
  final controller = Get.find<SearchController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
        children: [
          buildSearchField(context, controller.searchForNews),
          controller.isLoading
            ? Expanded(child: showCircularProgress())
            : Expanded(
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemCount: controller.searchedNews.length,
                  separatorBuilder: (context, index) => customDivider(),
                  itemBuilder: (_, index) {
                    News news = controller.searchedNews[index];
                    return NewsItem(news);
                  },
                ),
              ),
        ],
      ),
    );
  }

  // This function to build "TextField" for search
  Widget buildSearchField(BuildContext context, Function action) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: TextFormField(
        style: TextStyle(
          fontSize: 20,
          color: Get.theme.buttonColor,
        ),
        decoration: InputDecoration(
          hintText: 'Search...',
          fillColor: Theme.of(context).focusColor,
          filled: true,
          hintStyle: TextStyle(
            fontSize: 20,
            color: Get.theme.hintColor,
          ),
          prefixIcon: Icon(
            Icons.search, 
            color: Get.theme.hintColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(80),
            borderSide: BorderSide.none
          ),
        ),
        onChanged: (value) => action(value),
      ),
    );
  }

}