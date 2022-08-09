import 'package:flutter/material.dart';

import '../../pages/initial/initial.service.dart';
import 'brands_select.dart';
import 'model_select.dart';
import 'simple_model_select.dart';
import 'years_select.dart';

class Forms extends StatefulWidget {
  final InitialService initialService;
  final Function updater;
  final Color? selectColor;
  final Color? textColor;

  const Forms({
    required this.initialService,
    required this.updater,
    this.selectColor,
    this.textColor,
    Key? key,
  }) : super(key: key);

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BrandsSelect(
          initialService: widget.initialService,
          selectColor: widget.selectColor,
          textColor: widget.textColor,
          onChange: (s) async {
            widget.initialService.selected = s;

            if (s != '-1') {
              widget.initialService.selectedModeloResumido = "-1";
              widget.initialService.selectedModelo = "-1";
              widget.initialService.selectedAno = "-1";
              await widget.initialService.getModels();
              widget.updater();
            }

            setState(() {});
          },
        ),
        widget.initialService.selected != '-1'
            ? SimpleModelSelect(
                initialService: widget.initialService,
                selectColor: widget.selectColor,
                textColor: widget.textColor,
                onChange: (s) async {
                  setState(() {
                    widget.initialService.selectedModeloResumido = s;

                    if (s != '-1') {
                      widget.initialService.selectedModelo = "-1";
                      widget.initialService.selectedAno = "-1";
                      widget.updater();
                    }
                  });
                },
              )
            : Container(),
        widget.initialService.selectedModeloResumido != '-1'
            ? ModelSelect(
                initialService: widget.initialService,
                selectColor: widget.selectColor,
                textColor: widget.textColor,
                onChange: (s) async {
                  widget.initialService.selectedModelo = s;
                  await widget.initialService.getYears();

                  setState(() {
                    if (s != '-1') {
                      widget.initialService.selectedAno = "-1";
                      widget.updater();
                    }
                  });
                },
              )
            : Container(),
        widget.initialService.selectedModelo != '-1'
            ? YearsSelect(
                initialService: widget.initialService,
                selectColor: widget.selectColor,
                textColor: widget.textColor,
                onChange: (s) async {
                  setState(() {
                    widget.initialService.selectedAno = s;
                    widget.updater();
                  });
                },
              )
            : Container(),
      ],
    );
  }
}
