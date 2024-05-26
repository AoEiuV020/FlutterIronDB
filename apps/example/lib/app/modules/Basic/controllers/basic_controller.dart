import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iron_db/iron_db.dart';

class BasicController extends GetxController {
  final db = Iron.db.sub('Basic');
  final textControllerString = TextEditingController();
  final textControllerMultiline = TextEditingController();
  final textControllerNumber = TextEditingController();
  final textControllerResult = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  @override
  void onClose() {
    super.onClose();
    textControllerString.dispose();
    textControllerMultiline.dispose();
    textControllerNumber.dispose();
    textControllerResult.dispose();
  }

  void loadData() async {
    textControllerString.text = await db.read<String>('String') ?? '';
    textControllerMultiline.text = await db.read<String>('Multiline') ?? '';
    textControllerNumber.text =
        (await db.read<double>('Number'))?.toString() ?? '';
    textControllerResult.text += '读取成功\n';
  }

  void saveData() {
    db.write('String', textControllerString.text);
    db.write('Multiline', textControllerMultiline.text);
    db.write(
        'Number',
        textControllerNumber.text.isEmpty
            ? null
            : double.parse(textControllerNumber.text));
    textControllerResult.text += '保存成功: ${db.getPath()}\n';
  }

  void clearData() {
    db.drop();
    textControllerString.text = '';
    textControllerMultiline.text = '';
    textControllerNumber.text = '';
    textControllerResult.text += '清除成功\n';
  }
}
