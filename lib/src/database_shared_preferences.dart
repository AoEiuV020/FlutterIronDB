import 'dart:convert';
import 'dart:typed_data';

import 'package:shared_preferences/shared_preferences.dart';

import 'database.dart';
import 'logger.dart';
import 'serialize.dart';

class DatabaseSharedPreferences implements Database {
  final String base;
  final SubSerializer subSerializer;
  final KeySerializer keySerializer;
  final DataSerializer dataSerializer;
  final String prefix;

  DatabaseSharedPreferences(this.base, this.prefix, this.subSerializer,
      this.keySerializer, this.dataSerializer);

  String resolve(String base, String sub) {
    if (base.isEmpty) {
      return sub;
    }
    return '${base}_$sub';
  }

  String getAssetsKey(String key) {
    final filename = resolve(prefix, keySerializer.serialize(key));
    return resolve(base, filename);
  }

  @override
  String getPath() => '${base}_$prefix';

  @override
  Database sub(String table) {
    table = subSerializer.serialize(table);
    final subPrefix = resolve(prefix, table);
    logger.finer('sub: ${base}_$subPrefix');
    return DatabaseSharedPreferences(
        base, subPrefix, subSerializer, keySerializer, dataSerializer);
  }

  @override
  Future<T?> read<T>(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final realKey = getAssetsKey(key);
    final str = prefs.getString(realKey);
    if (str == null) {
      return null;
    }
    final Object data;
    if (T == Uint8List) {
      data = base64.decode(str);
    } else {
      data = str;
    }
    return dataSerializer.deserialize<T>(data);
  }

  @override
  Future<void> write<T>(String key, T? value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final realKey = getAssetsKey(key);
    if (value == null) {
      await prefs.remove(realKey);
      return;
    }
    final data = dataSerializer.serialize<T>(value);
    final String str;
    if (data is String) {
      str = data;
    } else {
      assert(data is Uint8List);
      str = base64.encode(data);
    }
    await prefs.setString(realKey, str);
  }

  @override
  Future<void> drop() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final namePrefix = resolve(base, prefix);
    for (final key in prefs.getKeys()) {
      if (key.startsWith(namePrefix)) {
        await prefs.remove(key);
      }
    }
  }
}
