import 'package:flutter/material.dart';

import '../../pages/initial/initial.service.dart';
import '../../theme/colors.dart';
import '../button.dart';
import '../divider.dart';
import '../initial/forms.dart';

class AddModal extends StatefulWidget {
  final Function() addItem;
  final InitialService initialService;

  const AddModal({
    required this.addItem,
    required this.initialService,
    Key? key,
  }) : super(key: key);

  @override
  State<AddModal> createState() => _AddModalState();
}

class _AddModalState extends State<AddModal> {
  bool showButton = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Adicionar um carro a comparação',
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            ),
            const DividerSpace(size: 30),
            Forms(
              initialService: widget.initialService,
              updater: () {
                setState(() {
                  showButton = widget.initialService.selectedAno != '-1';
                });
              },
              selectColor: fipeColorPalette.shade50,
              textColor: fipeColorPalette.shade100,
            ),
            showButton
                ? FipeButton(
                    text: "Adicionar",
                    fn: () {
                      Navigator.of(context).pop();
                      widget.addItem();
                    },
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
