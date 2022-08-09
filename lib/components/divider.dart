import 'package:flutter/material.dart';

class DividerSpace extends StatelessWidget {
  final double size;
  final bool isWidth;

  const DividerSpace({
    required this.size,
    this.isWidth = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(Object context) {
    return SizedBox(
      height: isWidth ? 0 : size,
      width: isWidth ? size : 0,
    );
  }
}
