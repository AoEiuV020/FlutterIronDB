import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

import 'serialize.dart';

class ReplaceFileSeparator implements KeySerializer {
  const ReplaceFileSeparator();

  @override
  String serialize(String key) {
    RegExp specialChars = RegExp(r'[\\/:*?"<>|\s]');
    return key.replaceAll(specialChars, '');
  }
}

/// assets不支持汉字等，会自动url编码，导致长度变三倍，
/// 这里判断太长就使用md5摘要转16进制编码得到32字符，
class AssetsFilenameSerializer implements KeySerializer {
  const AssetsFilenameSerializer();

  @override
  String serialize(String key) {
    final encoded = Uri.encodeComponent(key);
    if (encoded.length > 32) {
      final bytes = utf8.encode(key);
      key = md5.convert(bytes).toString();
    } else {
      key = encoded;
    }
    return key;
  }
}

/// 默认的序列化器，
/// 字符串类型不处理，
/// 基本类型使用json序列化，
class DefaultDataSerializer implements DataSerializer {
  const DefaultDataSerializer();

  @override
  T deserialize<T>(dynamic data) {
    assert(data is String || data is Uint8List);
    if (T == String) {
      return data as T;
    }
    if (T == Uint8List) {
      return data as T;
    }
    return jsonDecode(data) as T;
  }

  @override
  dynamic serialize<T>(T value) {
    if (T == String) {
      return value as String;
    }
    if (T == Uint8List) {
      return value as Uint8List;
    }
    return jsonEncode(value);
  }
}
