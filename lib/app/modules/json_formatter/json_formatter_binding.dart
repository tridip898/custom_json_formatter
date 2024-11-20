import 'package:get/get.dart';

import 'json_formatter_controller.dart';

class JsonFormatterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JsonFormatterController>(
      () => JsonFormatterController(),
    );
  }
}
