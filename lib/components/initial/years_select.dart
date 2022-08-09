import 'package:fipe_app/models/years.dart';
import 'package:fipe_app/pages/initial/initial.service.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../divider.dart';
import '../select.dart';

class YearsSelect extends StatefulWidget {
  final InitialService initialService;
  final Function(String) onChange;
  final Color? selectColor;
  final Color? textColor;

  const YearsSelect({
    required this.initialService,
    required this.onChange,
    this.selectColor,
    this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  State<YearsSelect> createState() => _YearsSelect();
}

class _YearsSelect extends State<YearsSelect> {
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
    await widget.initialService.getYears();
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

    for (Years e in widget.initialService.years) {
      items.add(DropdownMenuItem<String>(
        value: e.ano,
        child: Text(e.ano),
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
          'Ano',
          style: TextStyle(
            color: widget.textColor ?? Colors.white,
            fontSize: 14,
          ),
        ),
        Select(
          items: items,
          value: widget.initialService.selectedAno,
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
