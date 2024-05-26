/// 数据库抽象类，
/// 提供读写等操作方法，
abstract interface class Database {
  /// 生成一个数据库的子数据库
  /// 该方法返回一个新的Database实例，该实例的存储路径是
  /// 在base数据库的table目录下
  Database sub(String table);

  /// 写入数据
  /// 将数据写入到数据库中
  /// 如果数据key已经存在，会被覆盖
  ///
  /// [key] 需要写入的键
  /// [value] 需要写入的值
  Future<void> write<T>(String key, T? value);

  /// 读取数据
  /// 读取数据库中指定的键对应的值
  ///
  /// [key] 需要读取的键
  ///
  /// 该方法返回的是Future<T?>，T?是可能为空的T类型
  Future<T?> read<T>(String key);

  /// 删除数据库
  /// 删除整个数据库，包括子数据库，
  Future<void> drop();

  /// 获取数据库的路径
  /// 该方法返回的是数据库的文件路径
  /// 调试用，
  String getPath();
}
