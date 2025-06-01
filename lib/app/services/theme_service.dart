
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeService {

  ThemeMode get theme => isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;

  bool isSavedDarkMode() => Get.isDarkMode;

  void switchTheme() {
    Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }
}
