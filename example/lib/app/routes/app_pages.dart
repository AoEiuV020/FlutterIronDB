// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import '../modules/Assets/bindings/assets_binding.dart';
import '../modules/Assets/controllers/assets_controller.dart';
import '../modules/Basic/bindings/basic_binding.dart';
import '../modules/Basic/controllers/basic_controller.dart';
import '../modules/Basic/views/basic_view.dart';
import '../modules/Binary/bindings/binary_binding.dart';
import '../modules/Binary/views/binary_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

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
      name: _Paths.BASIC,
      page: () => const BasicView<BasicController>(),
      binding: BasicBinding(),
    ),
    GetPage(
      name: _Paths.ASSETS,
      page: () => const BasicView<AssetsController>(),
      binding: AssetsBinding(),
    ),
    GetPage(
      name: _Paths.BINARY,
      page: () => const BinaryView(),
      binding: BinaryBinding(),
    ),
  ];
}
