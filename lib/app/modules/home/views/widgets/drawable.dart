import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_do/app/modules/home/controllers/home_controller.dart';
import 'package:go_do/app/modules/home/controllers/theme_controller.dart';
import 'package:go_do/theme.dart';

import '../../../../routes/app_pages.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFC2E7F0),
            ),
            child: Center(child: Text("GoDo")),
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: Text('Analysis'.tr),
            onTap: () {
              Get.toNamed(Routes.ANALYSIS);
            },
          ),
          ExpansionTile(
            leading: const Icon(Icons.language),
            title: Text('Language'.tr),
            children: [
              ListTile(
                title: Text('Arabic'.tr),
                onTap: () async {
                  await Get.updateLocale(const Locale('ar'));
                  Get.delete();
                },
              ),
              ListTile(
                title: Text('English'.tr),
                onTap: () async {
                  await Get.updateLocale(const Locale('en'));
                  Get.delete();
                },
              ),
            ],
          ),
          ListTile(
            leading: Get.isDarkMode
                ? const Icon(Icons.wb_sunny)
                : const Icon(Icons.brightness_2),
            title: Text('Mode'.tr),
            onTap: () async {
              if (Get.isDarkMode) {
                Get.find<ThemeController>().changeTheme(AppTheme.light);
              } else {
                Get.find<ThemeController>().changeTheme(AppTheme.dark);
              }
              Get.delete();
            },
          ),
          ListTile(
              leading: const Icon(Icons.info),
              title: Obx(
                () => Text(
                    '${'AppVersion'.tr}: ${Get.find<HomeController>().appVersion.value}'),
              ))
        ],
      ),
    );
  }
}
