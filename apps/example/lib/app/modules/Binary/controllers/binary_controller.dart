import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iron_db/iron_db.dart';
import 'package:logging/logging.dart';

enum Keys {
  multiline,
}

class BinaryController extends GetxController {
  late final logger = Logger('Binary');
  late final db = getBaseDatabase().sub('Binary');
  final textControllerMultiline = TextEditingController();
  final textControllerResult = TextEditingController();
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  void onClose() {
    super.onClose();
    textControllerMultiline.dispose();
    textControllerResult.dispose();
  }

  Database getBaseDatabase() => Iron.mix([
        Iron.db,
        Iron.assetsDB(),
      ]);

  void appendToResult(String text) {
    textControllerResult.text += '$text\n';
  }

  void loadData() async {
    textControllerMultiline.text =
        deserialize(await db.read<Uint8List>(Keys.multiline.name)) ?? '';
    appendToResult('读取成功');
  }

  void saveData() {
    try {
      db.write(Keys.multiline.name, serialize(textControllerMultiline.text));
      appendToResult('保存成功: ${db.getPath()}');
    } catch (e, s) {
      logger.severe('保存失败', e, s);
      appendToResult('保存失败: $e');
    }
  }

  void clearData() {
    db.drop();
    textControllerMultiline.text = '';
    appendToResult('清除成功');
  }

  Uint8List serialize(String text) {
    // text 删除空格和换行然后16进制解码，
    final data = hex.decode(text.replaceAll(RegExp(r'\s+'), ''));
    return data as Uint8List;
  }

  String? deserialize(Uint8List? data) {
    if (data == null) {
      return null;
    }
    final str = hex.encode(data);
    return formatString(str);
  }

  /// 把字符串str每隔两个字符插入一个空格，每隔32个字符插入一个换行，
  String formatString(String str) {
    String formattedStr = '';
    int index = 0;
    for (int i = 0; i < str.length; i++) {
      formattedStr += str[i];
      index++;
      if (index % 2 == 0) {
        formattedStr += ' ';
      }
      if (index % 32 == 0) {
        formattedStr += '\n';
      }
    }
    return formattedStr;
  }
}
