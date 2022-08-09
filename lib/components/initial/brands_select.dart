import 'package:fipe_app/components/divider.dart';
import 'package:fipe_app/pages/initial/initial.service.dart';
import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../select.dart';

class BrandsSelect extends StatefulWidget {
  final InitialService initialService;
  final Function(String) onChange;
  final Color? selectColor;
  final Color? textColor;

  const BrandsSelect({
    required this.initialService,
    required this.onChange,
    this.selectColor,
    this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  State<BrandsSelect> createState() => _BrandsSelectState();
}

class _BrandsSelectState extends State<BrandsSelect> {
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
    await widget.initialService.getBrands();
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

    items.addAll(widget.initialService.brands.map((e) {
      return DropdownMenuItem<String>(
        value: e.idMarca,
        child: Text(e.nome),
      );
    }).toList());
  }

  @override
  Widget build(BuildContext context) {
    processItems();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Marcas',
          style: TextStyle(
            color: widget.textColor ?? Colors.white,
            fontSize: 14,
          ),
        ),
        Select(
          items: items,
          value: widget.initialService.selected,
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
