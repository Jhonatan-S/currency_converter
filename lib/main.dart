
import 'package:currency_converter/views/home_page/home_page.dart';
import 'package:flutter/material.dart';

import 'common/theme_input.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Currency Converter',
      theme: ThemeData(
        inputDecorationTheme: ThemeInput.themeInput,
      ),
      home: const HomePage(),
    );
  }
}
