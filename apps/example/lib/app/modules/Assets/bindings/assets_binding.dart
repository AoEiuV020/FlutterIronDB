import 'package:get/get.dart';
import 'package:iron_db/iron_db.dart';

import '../controllers/assets_controller.dart';

class AssetsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssetsController>(
      () => AssetsController(),
    );
  }

  static Future<void> init() async {
    if (!Get.isRegistered<Database>(tag: 'assetsDatabase')) {
      final Database db = await Iron.debugAssetsDB();
      Get.put(db, tag: 'assetsDatabase', permanent: true);
    }
  }
}
