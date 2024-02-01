import 'package:get/get.dart';

import '../modules/add_task_screen/bindings/add_task_screen_binding.dart';
import '../modules/add_task_screen/views/add_task_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/onboarding_screen/bindings/onboarding_screen_binding.dart';
import '../modules/onboarding_screen/views/onboarding_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TASK_SCREEN,
      page: () => const AddTaskScreenView(),
      binding: AddTaskScreenBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING_SCREEN,
      page: () => const OnboardingScreen(),
      binding: OnboardingScreenBinding(),
    ),
  ];
}
