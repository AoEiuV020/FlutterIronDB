import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/basic_controller.dart';

class BasicView extends GetView<BasicController> {
  const BasicView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('基本数据类型'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Text('字符串'),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: controller.textControllerString,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '输入字符串',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text('数字'),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: controller.textControllerNumber,
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '输入数字',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Obx(() => Checkbox(
                      value: controller.obsChecked.value,
                      onChanged: (v) => controller.setChecked(v!),
                    )),
                Expanded(
                  child: Obx(() => Slider(
                        value: controller.obsSeekBarValue.value,
                        min: 0,
                        max: 100,
                        onChanged: controller.setSeekBarValue,
                      )),
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: controller.loadData,
                  child: const Text('读取'),
                ),
                ElevatedButton(
                  onPressed: controller.saveData,
                  child: const Text('保存'),
                ),
                ElevatedButton(
                  onPressed: controller.clearData,
                  child: const Text('清空'),
                ),
              ],
            ),
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                const minHeight = 160.0;
                return Column(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          maxHeight: constraints.maxHeight - minHeight),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: controller.textControllerMultiline,
                          maxLines: null,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '输入多行文字',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      constraints: const BoxConstraints(minHeight: minHeight),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: controller.textControllerResult,
                          maxLines: null,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    )),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
