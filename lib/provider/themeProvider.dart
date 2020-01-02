import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_01/routes/applicaton.dart';
import 'package:flutter_01/utils/colors.dart';
import 'package:flutter_01/utils/style.dart';

enum Themes { DARK, LIGHT, SYSTEM }

class ThemeProvider extends ChangeNotifier {
  static const Map<Themes, String> themes = {
    Themes.DARK: 'Dark',
    Themes.LIGHT: 'Light',
    Themes.SYSTEM: 'System'
  };
  void syscTheme() {
    String theme = Application.theme;
    if (theme.isNotEmpty && theme != themes[Themes.SYSTEM]) {
      notifyListeners();
    }
  }

  void setTheme(Themes theme) {
    // Application.theme =
  }

  getTheme({bool isDark: false}) {
    var theme = Application.theme;
    switch (theme) {
      case "Dark":
        isDark = true;
        break;
      case "Light":
        isDark = false;
        break;
      default:
        break;
    }
    return ThemeData(
        errorColor: isDark ? Colours.dark_red : Colours.red,
        brightness: isDark ? Brightness.dark : Brightness.light,
        primaryColor: isDark ? Colours.dark_app_main : Colours.app_main,
        accentColor: isDark ? Colours.dark_app_main : Colours.app_main,
        // Tab指示器颜色
        indicatorColor: isDark ? Colours.dark_app_main : Colours.app_main,
        // 页面背景色
        scaffoldBackgroundColor: isDark ? Colours.dark_bg_color : Colors.white,
        // 主要用于Material背景色
        canvasColor: isDark ? Colours.dark_material_bg : Colors.white,
        // 文字选择色（输入框复制粘贴菜单）
        textSelectionColor: Colours.app_main.withAlpha(70),
        textSelectionHandleColor: Colours.app_main,
        textTheme: TextTheme(
          // TextField输入文字颜色
          subhead: isDark ? TextStyles.textDark : TextStyles.text,
          // Text文字样式
          body1: isDark ? TextStyles.textDark : TextStyles.text,
          // subtitle: isDark ? TextStyles.textDarkGray12 : TextStyles.textGray12,
        ),
        inputDecorationTheme: InputDecorationTheme(
            // hintStyle: isDark ? TextStyles.textHint14 : TextStyles.textDarkGray14,
            ),
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          color: isDark ? Colours.dark_bg_color : Colors.white,
          brightness: isDark ? Brightness.dark : Brightness.light,
        ),
        dividerTheme: DividerThemeData(
            color: isDark ? Colours.dark_line : Colours.line,
            space: 0.6,
            thickness: 0.6),
        cupertinoOverrideTheme: CupertinoThemeData(
          brightness: isDark ? Brightness.dark : Brightness.light,
        ));
  }
}
