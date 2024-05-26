import 'package:get/get.dart';
import 'package:iron_db/iron_db.dart';

import '../../Basic/controllers/basic_controller.dart';

class AssetsController extends BasicController {
  @override
  Database getBaseDatabase() => Get.find(tag: 'assetsDatabase');
}
