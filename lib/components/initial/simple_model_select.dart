import 'package:fipe_app/models/car_models.dart';
import 'package:fipe_app/pages/initial/initial.service.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../divider.dart';
import '../select.dart';

class SimpleModelSelect extends StatefulWidget {
  final InitialService initialService;
  final Function(String) onChange;
  final Color? selectColor;
  final Color? textColor;

  const SimpleModelSelect({
    required this.initialService,
    required this.onChange,
    this.selectColor,
    this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  State<SimpleModelSelect> createState() => _SimpleModelSelect();
}

class _SimpleModelSelect extends State<SimpleModelSelect> {
  List<DropdownMenuItem<String>> items = [
    const DropdownMenuItem<String>(
      value: '-1',
      child: Text('- Selecione -'),
    )
  ];

  @override
  void initState() {
    super.initState();
    start();
  }

  void start() async {
    await widget.initialService.getModels();
    processItems();
    setState(() {});
  }

  void processItems() {
    List<String> usedModels = [];

    items = [
      const DropdownMenuItem<String>(
        value: '-1',
        child: Text('- Selecione -'),
      )
    ];

    for (CarModels e in widget.initialService.carModels) {
      if (usedModels.contains(e.modeloResumido)) {
        continue;
      }

      items.add(DropdownMenuItem<String>(
        value: e.modeloResumido,
        child: Text(e.modeloResumido),
      ));

      usedModels.add(e.modeloResumido);
    }
  }

  @override
  Widget build(BuildContext context) {
    processItems();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Modelo',
          style: TextStyle(
            color: widget.textColor ?? Colors.white,
            fontSize: 14,
          ),
        ),
        Select(
          items: items,
          value: widget.initialService.selectedModeloResumido,
          fn: (s) {
            if (s != null) {
              widget.onChange(s);
            }
          },
          isFlat: true,
          color: widget.selectColor ?? fipeColorPalette.shade100,
        ),
        const DividerSpace(size: 10),
      ],
    );
  }
}
