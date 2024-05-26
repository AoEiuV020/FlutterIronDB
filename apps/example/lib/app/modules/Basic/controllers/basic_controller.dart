import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iron_db/iron_db.dart';
import 'package:logging/logging.dart';

enum Keys {
  string,
  multiline,
  number,
  checked,
  seekBarValue,
}

class BasicController extends GetxController {
  late final logger = Logger('Basic');
  late final db = getBaseDatabase().sub('Basic');
  final textControllerString = TextEditingController();
  final textControllerMultiline = TextEditingController();
  final textControllerNumber = TextEditingController();
  final textControllerResult = TextEditingController();
  final obsChecked = false.obs;
  final obsSeekBarValue = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  @override
  void onClose() {
    super.onClose();
    textControllerString.dispose();
    textControllerMultiline.dispose();
    textControllerNumber.dispose();
    textControllerResult.dispose();
    obsChecked.close();
    obsSeekBarValue.close();
  }

  Database getBaseDatabase() => Iron.mix([
        Iron.db,
        Iron.assetsDB(),
      ]);

  void appendToResult(String text) {
    textControllerResult.text += '$text\n';
  }

  void loadData() async {
    textControllerString.text = await db.read<String>(Keys.string.name) ?? '';
    textControllerMultiline.text =
        await db.read<String>(Keys.multiline.name) ?? '';
    textControllerNumber.text =
        (await db.read<int>(Keys.number.name))?.toString() ?? '';
    obsChecked.value = await db.read<bool>(Keys.checked.name) ?? false;
    obsSeekBarValue.value =
        await db.read<double>(Keys.seekBarValue.name) ?? 0.0;
    appendToResult('读取成功');
  }

  void saveData() {
    try {
    db.write(Keys.string.name, textControllerString.text);
    db.write(Keys.multiline.name, textControllerMultiline.text);
    db.write(
        Keys.number.name,
        textControllerNumber.text.isEmpty
            ? null
            : int.parse(textControllerNumber.text));
    db.write(Keys.checked.name, obsChecked.value);
    db.write(Keys.seekBarValue.name, obsSeekBarValue.value);
    appendToResult('保存成功: ${db.getPath()}');
    } catch (e, s) {
      logger.severe('保存失败', e, s);
      appendToResult('保存失败: $e');
    }
  }

  void clearData() {
    db.drop();
    textControllerString.text = '';
    textControllerMultiline.text = '';
    textControllerNumber.text = '';
    obsChecked.value = false;
    obsSeekBarValue.value = 0;
    appendToResult('清除成功');
  }

  void setChecked(bool value) {
    obsChecked.value = value;
  }

  void setSeekBarValue(double value) {
    obsSeekBarValue.value = value;
  }
}
