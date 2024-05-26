import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iron_db/iron_db.dart';

enum BasicKey {
  string,
  multiline,
  number,
  checked,
  seekBarValue,
}

class BasicController extends GetxController {
  final db = Iron.db.sub('Basic');
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

  void appendToResult(String text) {
    textControllerResult.text += text;
  }

  void loadData() async {
    textControllerString.text =
        await db.read<String>(BasicKey.string.name) ?? '';
    textControllerMultiline.text =
        await db.read<String>(BasicKey.multiline.name) ?? '';
    textControllerNumber.text =
        (await db.read<int>(BasicKey.number.name))?.toString() ?? '';
    obsChecked.value = await db.read<bool>(BasicKey.checked.name) ?? false;
    obsSeekBarValue.value =
        await db.read<double>(BasicKey.seekBarValue.name) ?? 0.0;
    appendToResult('读取成功');
  }

  void saveData() {
    db.write(BasicKey.string.name, textControllerString.text);
    db.write(BasicKey.multiline.name, textControllerMultiline.text);
    db.write(
        BasicKey.number.name,
        textControllerNumber.text.isEmpty
            ? null
            : int.parse(textControllerNumber.text));
    db.write(BasicKey.checked.name, obsChecked.value);
    db.write(BasicKey.seekBarValue.name, obsSeekBarValue.value);
    appendToResult('保存成功: ${db.getPath()}\n');
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
