import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:iron_db/iron_db.dart';
// ignore: implementation_imports
import 'package:iron_db/src/database_assets.dart';
// ignore: implementation_imports
import 'package:iron_db/src/database_assets_io.dart';
// ignore: implementation_imports
import 'package:iron_db/src/logger.dart';
import 'package:path/path.dart' as path;

Future<Database> getDebugAssetsDatabase(
    String assetsBase, DataSerializer dataSerializer) async {
  if (!kDebugMode) {
    logger.warning('getDebugAssetsDatabase: not in debug mode');
    return DatabaseAssets(assetsBase, '', dataSerializer);
  }
  if (Platform.isAndroid || Platform.isIOS) {
    logger.warning('getDebugAssetsDatabase: not supported on Android or iOS');
    return DatabaseAssets(assetsBase, '', dataSerializer);
  }
  final executable = Platform.resolvedExecutable;
  logger.fine('executable: $executable');
  String? appProjectPath;
  if (Platform.isMacOS) {
    // .../FlutterIronDB/apps/example/build/macos/Build/Products/Debug/example.app/Contents/MacOS/example
    appProjectPath =
        path.canonicalize(path.join(executable, '../../../../../../../../../'));
    // mac必须手动选择目录后才有权限读写，所以这里会弹出选择框，选择项目所在目录，正常来说直接确定就好，
    // 这里需要依赖库file_selector，
    appProjectPath = await getDirectoryPath(initialDirectory: appProjectPath);
  } else if (Platform.isWindows || Platform.isLinux) {
    // ...\FlutterIronDB\apps\example\build\windows\x64\runner\Debug\example.exe
    appProjectPath =
        path.canonicalize(path.join(executable, '../../../../../../'));
  }
  if (appProjectPath != null) {
    final assetsPath = path.join(appProjectPath, assetsBase);
    logger.fine('writable assets dir: $assetsPath');
    return DatabaseAssetsIO(Directory(assetsPath), '', dataSerializer);
  }
  logger.warning('getDebugAssetsDatabase: no app project path');
  return DatabaseAssets(assetsBase, '', dataSerializer);
}
