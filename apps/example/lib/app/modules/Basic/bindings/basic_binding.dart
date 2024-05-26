import 'package:get/get.dart';

import '../controllers/basic_controller.dart';

class BasicBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BasicController>(
      () => BasicController(),
    );
  }
}
