# iron_db
废铁key-value数据库，  
主打的是简单方便，  

[![img](https://img.shields.io/github/release/AoEiuV020/FlutterIronDB.svg)](https://github.com/AoEiuV020/FlutterIronDB/releases)
[![CI](https://github.com/AoEiuV020/FlutterIronDB/workflows/CI/badge.svg)](https://github.com/AoEiuV020/FlutterIronDB/actions)
[![Using melos](https://img.shields.io/badge/maintained%20with-melos-f700ff.svg?style=flat-square)](https://github.com/invertase/melos)
[![Main version](https://img.shields.io/pub/v/iron_db.svg)](https://pub.dev/packages/iron_db)

## Features

1. 多级目录文件形式保存数据，一个key就是一个文件，方便人工处理，
1. web支持，但使用SharedPreferences凑合，
1. 支持从assets读取数据，并可以命令行程序写入数据到assets目录，
1. 可自定义路径序列化方式，默认是简单把key中不能作为路径的字符删除，
1. 可自定义数据序列化方式，默认使用json序列化，支持基本数据类型，
1. 默认String和Uint8List数据会原原本本写入到文件，可修改，
1. 类型由开发者自己把握，保存double读取int会抛运行时异常，注意泛型类型推断，

## Getting started

```shell
flutter pub add iron_db
```

## Usage
[iron_db_test.dart](./test/iron_db_test.dart)
```dart
import 'package:iron_db/iron_db.dart';
WidgetsFlutterBinding.ensureInitialized();
await Iron.init();
final db = Iron.db.sub('string');
String? value = 'value';
await db.write('key', value);
value = await db.read<String>('key');
expect(value, 'value');
```

## TODO
- web异步处理数据支持，目前只有isolate异步支持，
- 支持Stream流数据存取，暂不确定需求，没有设计，