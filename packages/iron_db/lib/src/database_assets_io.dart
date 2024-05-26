import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as path;

import 'isolate_transformer.dart';
import 'database.dart';
import 'logger.dart';
import 'serialize.dart';
import 'serialize_impl.dart';

/// 针对flutter assets，按assets要求的文件名格式读写，
/// 重点在于assets不包含子目录，所以sub不能用子目录分级，多级sub改成文件名中多级下划线分割，
class DatabaseAssetsIO implements Database {
  final Directory folder;
  final SubSerializer subSerializer = const AssetsFilenameSerializer();
  final KeySerializer keySerializer = const AssetsFilenameSerializer();
  final DataSerializer dataSerializer;
  final String prefix;

  DatabaseAssetsIO(this.folder, this.prefix, this.dataSerializer);

  String resolve(String base, String sub) {
    if (base.isEmpty) {
      return sub;
    }
    return '${base}_$sub';
  }

  /// 文件名和所在目录之间是斜杆分割，文件名内部的层级划分用下划线分割，
  String getAssetsKey(String key) {
    final filename = resolve(prefix, keySerializer.serialize(key));
    return path.join(folder.path, filename);
  }

  @override
  String getPath() => folder.path;

  @override
  Database sub(String table) {
    table = subSerializer.serialize(table);
    final subPrefix = resolve(prefix, table);
    logger.finer('sub: $folder/$subPrefix');
    return DatabaseAssetsIO(folder, subPrefix, dataSerializer);
  }

  @override
  Future<T?> read<T>(String key) async {
    final file = File(getAssetsKey(key));
    if (!await file.exists()) {
      return null;
    }
    if (T == Uint8List) {
      return await file.readAsBytes() as T;
    }
    return await IsolateTransformer().convert(
        file,
        (e) => e
            .asyncExpand((file) => file.openRead())
            .transform(utf8.decoder)
            .join()
            .asStream()
            .map((str) => dataSerializer.deserialize<T>(str)));
  }

  @override
  Future<void> write<T>(String key, T? value) async {
    await folder.create(recursive: true);
    final file = File(getAssetsKey(key));
    if (value == null) {
      await file.delete();
      return;
    }
    File('/Volumes/IAPFS/home/git/FlutterIronDB/apps/example/test.txt')
        .writeAsStringSync('asdf');
    await IsolateTransformer().run(value, (T value) async {
      final data = dataSerializer.serialize<T>(value);
      final write = file.openWrite();
      if (data is String) {
        write.write(data);
      } else {
        assert(data is Uint8List);
        write.add(data);
      }
      await write.flush();
      await write.close();
    });
  }

  @override
  Future<void> drop() async {
    await IsolateTransformer().run(folder, (folder) async {
      if (!await folder.exists()) {
        return;
      }
      final pathPrefix = path.join(folder.path, prefix);
      await for (var file in folder.list()) {
        if (file.path.startsWith(pathPrefix)) {
          await file.delete();
        }
      }
    });
  }
}
