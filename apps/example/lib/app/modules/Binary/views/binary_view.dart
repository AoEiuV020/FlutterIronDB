import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/binary_controller.dart';

class BinaryView extends GetView<BinaryController> {
  const BinaryView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('二进制数据存取'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9a-fA-F\s]'))
                          ],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: '输入16进制编码内容',
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
                            hintText: '操作日志',
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
