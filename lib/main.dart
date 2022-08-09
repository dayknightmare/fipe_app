import 'package:fipe_app/pages/initial/initial.page.dart';
import 'package:fipe_app/theme/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fipe app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: fipeColorPalette,
        fontFamily: 'Nunito',
      ),
      home: const InitialPage(),
    );
  }
}
