import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iron_db/iron_db.dart';
import 'package:logging/logging.dart';

import 'app/routes/app_pages.dart';

void main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    log(
      record.message,
      name: record.loggerName,
      level: record.level.value,
      time: record.time,
      error: record.error,
      stackTrace: record.stackTrace,
    );
  });
  WidgetsFlutterBinding.ensureInitialized();
  await Iron.init();
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
