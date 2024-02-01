import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_do/app/modules/home/bindings/home_binding.dart';
import 'package:go_do/app_translations.dart';
import 'package:go_do/theme.dart';
import 'package:sizer/sizer.dart';
import 'app/modules/home/controllers/theme_controller.dart';
import 'app/routes/app_pages.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Get.put(ThemeController());
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: theme.theme,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        title: "TODO",
        translations: AppTranslations(),
        locale: Locale('en', 'US'),
        fallbackLocale: Locale('en', 'US'),
        initialBinding: HomeBinding(),
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
      );
    });
  }
}
