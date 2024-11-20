import 'package:get/get.dart';

import '../modules/home/home_binding.dart';
import '../modules/home/home_view.dart';
import '../modules/json_formatter/json_formatter_binding.dart';
import '../modules/json_formatter/json_formatter_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.JSON_FORMATTER;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.JSON_FORMATTER,
      page: () => const JsonFormatterView(),
      binding: JsonFormatterBinding(),
    ),
  ];
}
