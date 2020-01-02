import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'colors.dart';

class TextStyles {
  static const TextStyle text = const TextStyle(
      color: Colours.text,
      // https://github.com/flutter/flutter/issues/40248
      textBaseline: TextBaseline.alphabetic);
  static const TextStyle textDark = const TextStyle(
      color: Colours.dark_text, textBaseline: TextBaseline.alphabetic);
}
