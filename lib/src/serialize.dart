/// 数据库读写的键本身的序列化接口，
/// 用于从key得到文件路径这一步，
abstract interface class KeySerializer {
  /// 序列化
  String serialize(String key);
}

/// 子数据库名的序列化接口，
/// 实际上和key的序列化是一样的，
typedef SubSerializer = KeySerializer;

/// 序列化数据的接口类，
/// 这里的dynamic是针对 String 或者 Uint8List 做的优化，不支持其他类型，
/// 主要是SharedPreferences的存储类型是String, 不支持Uint8List, 而io底层读写的是Uint8List，
abstract interface class DataSerializer {
  /// 序列化，
  /// 参数可以是基本类型，包括String, List, Map, Uint8List,
  /// 返回值为String或者Uint8List,
  dynamic serialize<T>(T value);

  /// 反序列化，
  /// 参数可以是String或者Uint8List，
  /// 返回值为，支持基本类型，包括String, List, Map, Uint8List,
  T deserialize<T>(dynamic data);
}
