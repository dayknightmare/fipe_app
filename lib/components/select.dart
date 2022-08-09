import 'package:fipe_app/theme/colors.dart';
import 'package:flutter/material.dart';

class Select extends StatelessWidget {
  final List<DropdownMenuItem<String>> items;
  final String value;
  final Function(String?) fn;
  final bool isFlat;
  final Color? color;

  const Select({
    required this.items,
    required this.value,
    required this.fn,
    this.isFlat = false,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        border: Border.all(
          color: isFlat ? Colors.transparent : Theme.of(context).primaryColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: DropdownButton(
          dropdownColor: color ?? Colors.white,
          iconEnabledColor: luminanceColor(color ?? Colors.white),
          underline: Container(),
          items: items,
          value: value,
          isExpanded: true,
          onChanged: fn,
          style: TextStyle(
            color: luminanceColor(color ?? Colors.white),
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
