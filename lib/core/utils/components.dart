import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Custom Divider For "News", "Search" and "Favorites" Screens
Widget customDivider() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Divider(color: Get.theme.dividerColor),
  );
}

// For Circular Progress Indicator
Widget showCircularProgress() {
  return SpinKitFadingCircle(
    color: Get.theme.accentColor,
  );
}

// For Snackbar
void showSnackbar(String title, String message) {
  Get.snackbar(
    title,
    message,
    borderRadius: 0,
    margin: EdgeInsets.all(0),
    backgroundColor: Colors.grey[900],
    colorText: Colors.white,
  );
}