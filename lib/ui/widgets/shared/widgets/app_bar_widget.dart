import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app/modules/home/controllers/theme_controller.dart';
import '../../../../theme.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  // TODO: implement preferredSize
  // Size get preferredSize => throw UnimplementedError();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: context.theme.colorScheme.background,
        leading: Obx(() => Switch(
              value: Get.isDarkMode,
              onChanged: (value) async {
                if(Get.isDarkMode){
                  Get.find<ThemeController>().changeTheme(AppTheme.light);
                }
               else{
                Get.find<ThemeController>().changeTheme(AppTheme.dark);
               }
              
              },
              thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.selected)) {
                    return const Icon(Icons.brightness_2);
                  }

                  return const Icon(
                    Icons.brightness_4_outlined,
                    color: Colors.grey,
                    size: 25,
                  );
                },
              ),
            )),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person,
              size: 25,
              color: Colors.grey,
            ),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        
        ],
      ),
    );
  }
}
