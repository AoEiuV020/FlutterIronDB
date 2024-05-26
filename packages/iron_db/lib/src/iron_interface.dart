import 'database.dart';
import 'serialize.dart';

abstract interface class IronInterface {
  Future<void> init(
      {String? base,
      KeySerializer? keySerializer,
      DataSerializer? dataSerializer});

  /// 默认数据库，保存在app私有目录，
  Database get db;

  /// 只读数据库，数据来源是assets，
  /// 开发时使用[debugAssetsDB]生成assets中的数据，
  Database assetsDB([String assetsBase = 'assets/IronDB']);

  /// 用于开发时往assets目录中写入默认数据，
  /// release模式、web端、手机端为只读，只有本机debug时才能写入，
  Future<Database> debugAssetsDB([String assetsBase = 'assets/IronDB']);

  /// 聚合多个数据库，
  /// 写入的数据将会被按照顺序写入到每个数据库中，
  /// 读取时返回第一个非空值，如果都是空值，则返回null，
  Database mix(List<Database> list);
}
