import 'package:flutter/material.dart';

class ThemeInput {
  ThemeInput._();

  static const InputDecorationTheme themeInput = InputDecorationTheme(

    border: UnderlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(28))),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.red)
    )
 
 
  );
}
