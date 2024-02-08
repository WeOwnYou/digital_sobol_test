import 'package:flutter/services.dart';

class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;

  MaskedTextInputFormatter(this.mask);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;

    // Удаляем все символы, кроме цифр
    final unmaskedText = newText.replaceAll(RegExp(r'\D'), '');

    final maskedText = _applyMask(unmaskedText);

    return TextEditingValue(
      text: maskedText,
      selection: TextSelection.collapsed(offset: maskedText.length),
    );
  }

  String _applyMask(String text) {
    var index = 0;
    final result = StringBuffer();

    for (var i = 0; i < mask.length; i++) {
      if (index >= text.length) {
        break;
      }

      if (mask[i] == 'x') {
        result.write(text[index]);
        index++;
      } else {
        result.write(mask[i]);
      }
    }

    return result.toString();
  }
}
