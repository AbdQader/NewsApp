import 'package:get/get.dart';
import '../controllers/news_controller.dart';
import '../controllers/navigation_controller.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationController>(() => NavigationController());
    Get.lazyPut<NewsController>(() => NewsController());
  }

}