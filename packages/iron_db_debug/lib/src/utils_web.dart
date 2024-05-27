import 'package:iron_db/iron_db.dart';
// ignore: implementation_imports
import 'package:iron_db/src/utils_web.dart';

Future<Database> getDebugAssetsDatabase(
        String assetsBase, DataSerializer dataSerializer) async =>
    getDefaultAssetsDatabase(assetsBase, dataSerializer);
