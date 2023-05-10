import 'package:flutter/material.dart';
import 'package:pr_test1/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';

class Utils {
  BuildContext context;
  Utils(this.context);

  bool get getTheme => Provider.of<DarkThemeProvider>(context).getDarkTheme;

  get color => getTheme ? Colors.white : Colors.black;

  Size get getscreenSize => MediaQuery.of(context).size;
}
