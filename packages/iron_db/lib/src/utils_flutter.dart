import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'database.dart';
import 'database_assets.dart';
import 'database_assets_io.dart';
import 'database_impl.dart';
import 'serialize.dart';

/// linux: /home/<username>/.local/share/<organization>.<app_name>
/// mac: /Users/<username>/Library/Containers/<organization>.<app_name>/Data/Library/Application Support/<organization>.<app_name>
Future<String> getDefaultBase() async {
  final folder = await getApplicationSupportDirectory();
  return path.join(folder.path, 'IronDB');
}

Database getDefaultDatabase(String base, KeySerializer keySerializer,
        DataSerializer dataSerializer) =>
    DatabaseImpl(base, keySerializer, dataSerializer);

Database getDefaultAssetsDatabase(
        String assetsBase, DataSerializer dataSerializer) =>
    DatabaseAssets(assetsBase, '', dataSerializer);

Future<Database> getDebugAssetsDatabase(
    String assetsBase, DataSerializer dataSerializer) async {
  if (!kDebugMode) {
    return DatabaseAssets(assetsBase, '', dataSerializer);
  }
  String? appProjectPath;
  if (Platform.isMacOS) {
    // .../FlutterIronDB/apps/example/build/macos/Build/Products/Debug/example.app/Contents/MacOS/example
    final executable = Platform.resolvedExecutable;
    appProjectPath =
        path.canonicalize(path.join(executable, '../../../../../../../../../'));
    // mac必须手动选择目录后才有权限读写，所以这里会弹出选择框，选择项目所在目录，正常来说直接确定就好，
    appProjectPath = await getDirectoryPath(initialDirectory: appProjectPath);
  }
  if (appProjectPath != null) {
    return DatabaseAssetsIO(
        Directory(path.join(appProjectPath, assetsBase)), '', dataSerializer);
  }
  return DatabaseAssets(assetsBase, '', dataSerializer);
}
