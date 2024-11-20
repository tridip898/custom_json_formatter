import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class JsonFormatterController extends GetxController {
  final textController = TextEditingController();
  final textFocus = FocusNode();

  final formattedJson = "".obs, error = "".obs;
  final isExpanded = <bool>[].obs;
  int lineNumber = 1;
  final Map<int, bool> foldState = <int, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void jsonFormat() {
    try {
      formattedJson.value = customFormatJson(textController.text);
      error.value = "";
    } catch (e) {
      error.value = "Invalid JSON: ${e.toString()}";
    }
  }

  String customFormatJson(String jsonText) {
    String cleaned = jsonText.replaceAll(RegExp(r"\s+"), " ");
    cleaned = cleaned.replaceAllMapped(RegExp(r"\s*([,:{}\[\]])\s*"), (match) {
      return "${match.group(1)}";
    });

    int indentLevel = 0;
    final buffer = StringBuffer();
    bool insideString = false;
    int currentLine = 0;

    for (int i = 0; i < cleaned.length; i++) {
      String char = cleaned[i];

      if (char == '"') {
        insideString = !insideString;
      }

      if (!insideString) {
        if (char == '{' || char == '[') {
          buffer.write(char);
          if (foldState[currentLine] == false) {
            buffer.write(" ... ");
            i = skipBlock(cleaned, i);
            buffer.write(char == '{' ? "}" : "]");
          } else {
            buffer.writeln();
            currentLine++;
            indentLevel++;
            buffer.write('    ' * indentLevel);
          }
        } else if (char == '}' || char == ']') {
          buffer.writeln();
          currentLine++;
          indentLevel--;
          buffer.write('    ' * indentLevel);
          buffer.write(char);
        } else if (char == ',') {
          buffer.write(char);
          buffer.writeln();
          currentLine++;
          buffer.write('    ' * indentLevel);
        } else if (char == ':') {
          buffer.write("$char ");
        } else {
          buffer.write(char);
        }
      } else {
        buffer.write(char);
      }
    }

    return buffer.toString();
  }

  int skipBlock(String text, int startIndex) {
    int depth = 0;
    bool insideString = false;

    for (int i = startIndex; i < text.length; i++) {
      String char = text[i];

      if (char == '"') {
        insideString = !insideString;
      }

      if (!insideString) {
        if (char == '{' || char == '[') {
          depth++;
        } else if (char == '}' || char == ']') {
          depth--;
          if (depth == 0) {
            return i;
          }
        }
      }
    }
    return startIndex;
  }

  void toggleFoldState(int lineIndex) {
    foldState[lineIndex] = !(foldState[lineIndex] ?? true);
    jsonFormat();
  }
}
