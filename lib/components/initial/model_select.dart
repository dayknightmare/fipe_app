import 'package:fipe_app/models/car_models.dart';
import 'package:fipe_app/pages/initial/initial.service.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../divider.dart';
import '../select.dart';

class ModelSelect extends StatefulWidget {
  final InitialService initialService;
  final Function(String) onChange;
  final Color? selectColor;
  final Color? textColor;

  const ModelSelect({
    required this.initialService,
    required this.onChange,
    this.textColor,
    this.selectColor,
    Key? key,
  }) : super(key: key);

  @override
  State<ModelSelect> createState() => _ModelSelect();
}

class _ModelSelect extends State<ModelSelect> {
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
    items = [
      const DropdownMenuItem<String>(
        value: '-1',
        child: Text('- Selecione -'),
      )
    ];

    for (CarModels e in widget.initialService.carModels) {
      if (e.modeloResumido != widget.initialService.selectedModeloResumido) {
        continue;
      }

      items.add(DropdownMenuItem<String>(
        value: e.idModelo,
        child: Text(e.modelo),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    processItems();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Versão',
          style: TextStyle(
            color: widget.textColor ?? Colors.white,
            fontSize: 14,
          ),
        ),
        Select(
          items: items,
          value: widget.initialService.selectedModelo,
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
