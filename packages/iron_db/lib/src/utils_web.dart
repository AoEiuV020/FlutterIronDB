import 'database.dart';
import 'database_shared_preferences.dart';
import 'serialize.dart';
import 'database_assets.dart';

Future<String> getDefaultBase() async => 'IronDB';

/// 开发者工具 - 应用 - 本地存储空间，
Database getDefaultDatabase(String base, KeySerializer keySerializer,
        DataSerializer dataSerializer) =>
    DatabaseSharedPreferences(
        base, '', keySerializer, keySerializer, dataSerializer);

Database getDefaultAssetsDatabase(
        String assetsBase, DataSerializer dataSerializer) =>
    DatabaseAssets(assetsBase, '', dataSerializer);
