import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'database.dart';
import 'database_assets.dart';
import 'database_impl.dart';
import 'serialize.dart';

/// linux: /home/<username>/.local/share/<organization>.<app_name>
/// mac: /Users/<username>/Library/Containers/<organization>.<app_name>/Data/Library/Application Support/<organization>.<app_name>
Future<String> getDefaultBase() async {
  final folder = await getApplicationSupportDirectory();
  return path.join(folder.path, 'IronDB');
}

Database getDefaultDatabase(
  String base, 
  SubSerializer subSerializer,
  KeySerializer keySerializer,
  DataSerializer dataSerializer
) =>
    DatabaseImpl(base, keySerializer, subSerializer, dataSerializer);

Database getDefaultAssetsDatabase(
        String assetsBase, DataSerializer dataSerializer) =>
    DatabaseAssets(assetsBase, '', dataSerializer);
