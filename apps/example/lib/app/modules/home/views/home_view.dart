import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../Assets/bindings/assets_binding.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => Get.toNamed(Routes.BASIC),
                child: const Text('基本数据类型'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await AssetsBinding.init();
                  Get.toNamed(Routes.ASSETS);
                },
                child: const Text('修改Assets默认值'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
