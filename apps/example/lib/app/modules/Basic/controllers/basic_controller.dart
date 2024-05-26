import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iron_db/iron_db.dart';

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

  void loadData() async {
    textControllerString.text = await db.read<String>('string') ?? '';
    textControllerMultiline.text = await db.read<String>('multiline') ?? '';
    textControllerNumber.text =
        (await db.read<int>('number'))?.toString() ?? '';
    obsChecked.value = await db.read<bool>('checked') ?? false;
    obsSeekBarValue.value = await db.read<double>('seekBarValue') ?? 0.0;
    textControllerResult.text += '读取成功\n';
  }

  void saveData() {
    db.write('string', textControllerString.text);
    db.write('multiline', textControllerMultiline.text);
    db.write(
        'number',
        textControllerNumber.text.isEmpty
            ? null
            : int.parse(textControllerNumber.text));
    db.write('checked', obsChecked.value);
    db.write('seekBarValue', obsSeekBarValue.value);
    textControllerResult.text += '保存成功: ${db.getPath()}\n';
  }

  void clearData() {
    db.drop();
    textControllerString.text = '';
    textControllerMultiline.text = '';
    textControllerNumber.text = '';
    textControllerResult.text += '清除成功\n';
    obsChecked.value = false;
    obsSeekBarValue.value = 0;
  }

  void setChecked(bool value) {
    obsChecked.value = value;
  }

  void setSeekBarValue(double value) {
    obsSeekBarValue.value = value;
  }
}
