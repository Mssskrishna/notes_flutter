// // main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/app/routes/app_pages.dart';
import 'package:flutter_application_1/app/services/theme_service.dart';
import 'package:flutter_application_1/app/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Notes App',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeService().theme,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
