import 'database.dart';
import 'serialize.dart';

abstract interface class IronInterface {
  Future<void> init(
      {String? base,
      KeySerializer? keySerializer,
      DataSerializer? dataSerializer});

  Database get db;

  Database assetsDB([String assetsBase = 'assets/IronDB']);

  Database mix(List<Database> list);
}
