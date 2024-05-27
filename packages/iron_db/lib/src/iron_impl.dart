import 'database.dart';
import 'iron_interface.dart';
import 'logger.dart';
import 'serialize.dart';
import 'database_mix.dart';
import 'serialize_impl.dart';
import 'utils_cmd.dart'
    if (dart.library.js_util) 'utils_web.dart'
    if (dart.library.ui) 'utils_flutter.dart';

class IronImpl implements IronInterface {
  bool _init = false;
  late final String base;
  late final KeySerializer keySerializer;
  late final DataSerializer dataSerializer;
  @override
  late final Database db =
      getDefaultDatabase(base, keySerializer, dataSerializer);

  @override
  Future<void> init(
      {String? base,
      KeySerializer? keySerializer,
      DataSerializer? dataSerializer}) async {
    if (_init) {
      logger.severe('init already');
      return;
    }
    _init = true;
    this.base = base ??= await getDefaultBase();
    logger.fine('init base: $base');
    this.keySerializer = keySerializer ?? const ReplaceFileSeparator();
    this.dataSerializer = dataSerializer ?? const DefaultDataSerializer();
  }

  @override
  Database assetsDB([String assetsBase = 'assets/IronDB']) {
    return getDefaultAssetsDatabase(assetsBase, dataSerializer);
  }

  @override
  Database mix(List<Database> list) {
    return DatabaseMix(list);
  }
}
