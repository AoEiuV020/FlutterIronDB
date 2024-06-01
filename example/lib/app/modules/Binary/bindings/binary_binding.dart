import 'package:get/get.dart';

import '../controllers/binary_controller.dart';

class BinaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BinaryController>(
      () => BinaryController(),
    );
  }
}
