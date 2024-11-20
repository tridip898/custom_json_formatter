import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'json_formatter_controller.dart';

class JsonFormatterView extends GetView<JsonFormatterController> {
  const JsonFormatterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 0.02.sw, vertical: 20.h),
          child: Column(
            children: [
              TextField(
                controller: controller.textController,
                decoration: InputDecoration(
                  hintText: "Paste your JSON here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                ),
                maxLines: 8,
                minLines: 5,
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: controller.jsonFormat,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Format JSON',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 6.w, vertical: 12.h),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Formatted Text: ",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        if (controller.error.value != "") ...[
                          SelectableText(
                            controller.error.value,
                            style: TextStyle(color: Colors.red),
                          ),
                          SizedBox(
                            height: 8.h,
                          )
                        ],
                        if (controller.formattedJson.value != "")
                          ...jsonDataWithLineNumbers(
                              controller.formattedJson.value),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  List<Widget> jsonDataWithLineNumbers(String formattedJson) {
    List<String> lines = formattedJson.split('\n');
    List<Widget> lineAndData = [];

    for (int i = 0; i < lines.length; i++) {
      lineAndData.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h),
          child: rowDataLineNumber(lines[i], i),
        ),
      );
    }

    return lineAndData;
  }

  Widget rowDataLineNumber(String line, int index) {
    bool isExpandable = line.contains('[') || line.contains('{');
    if (isExpandable) {
      return expandableRow(line, index);
    } else {
      return Row(
        children: [
          SizedBox(
            width: 0.04.sw,
            child: Text(
              '${index + 1}',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          SizedBox(width: 2.w),
          Expanded(
            child: Text(
              line,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      );
    }
  }

  expandableRow(String line, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Obx(() {
        bool isFolded = controller.foldState[index] ?? true;
        return Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 0.04.sw,
                  child: Row(
                    children: [
                      Text(
                        '${index + 1}',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      SizedBox(width: 2.w),
                      InkWell(
                        onTap: () {
                          controller.toggleFoldState(index);
                        },
                        child: Icon(
                          isFolded
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: SelectableText(
                    line,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            if (!isFolded) ...[
              buildExpandedContent(line),
            ]
          ],
        );
      }),
    );
  }

  buildExpandedContent(String line) {
    if (line.contains('{')) {
      return mapBlockContent(line);
    } else if (line.contains('[')) {
      return listBlockContent(line);
    }
    return Container();
  }

  Widget mapBlockContent(String line) {
    Map<String, dynamic> jsonMap = {};
    if (line.trim().startsWith('{') && line.trim().endsWith('}')) {
      jsonMap = customParseMap(line);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: jsonMap.entries.map((entry) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            children: [
              Text(
                '"${entry.key}": ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Expanded(
                child: Text(
                  entry.value.toString(),
                  style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget listBlockContent(String line) {
    List<dynamic> jsonArray = [];
    if (line.trim().startsWith('[') && line.trim().endsWith(']')) {
      jsonArray = customParseList(line);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: jsonArray.map((item) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            item.toString(),
            style: TextStyle(fontSize: 14, color: Colors.blueGrey),
          ),
        );
      }).toList(),
    );
  }

  Map<String, dynamic> customParseMap(String input) {
    final map = <String, dynamic>{};
    final mapRegex = RegExp(r'"(.*?)":\s*(.*?)(,|$)');

    for (final match in mapRegex.allMatches(input)) {
      final key = match.group(1) ?? '';
      final rawValue = match.group(2) ?? '';

      final value = parseJsonValue(rawValue);
      map[key] = value;
    }

    return map;
  }

  List<dynamic> customParseList(String input) {
    final list = <dynamic>[];
    final listRegex = RegExp(r'([^,\[\]]+)(,|$)');

    for (final match in listRegex.allMatches(input)) {
      final rawValue = match.group(1)?.trim() ?? '';
      if (rawValue.isNotEmpty) {
        final value = parseJsonValue(rawValue);
        list.add(value);
      }
    }

    return list;
  }

  dynamic parseJsonValue(String rawValue) {
    if (rawValue.startsWith('"') && rawValue.endsWith('"')) {
      return rawValue.substring(1, rawValue.length - 1);
    } else if (rawValue == "true" || rawValue == "false") {
      return rawValue == "true";
    } else if (rawValue.contains(RegExp(r'^\d+(\.\d+)?$'))) {
      return double.tryParse(rawValue) ?? int.tryParse(rawValue);
    } else if (rawValue.startsWith('{') && rawValue.endsWith('}')) {
      return customParseMap(rawValue);
    } else if (rawValue.startsWith('[') && rawValue.endsWith(']')) {
      return customParseList(rawValue);
    } else {
      return rawValue;
    }
  }
}
