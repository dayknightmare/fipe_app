import 'package:fipe_app/components/button.dart';
import 'package:fipe_app/theme/colors.dart';
import 'package:flutter/material.dart';

class RemoveModal extends StatefulWidget {
  final List<String> names;
  final Function(int index) onRemove;

  const RemoveModal({
    required this.names,
    required this.onRemove,
    Key? key,
  }) : super(key: key);

  @override
  State<RemoveModal> createState() => _RemoveModalState();
}

class _RemoveModalState extends State<RemoveModal> {
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
      child: ListView.builder(
        itemBuilder: (BuildContext ctx, int index) {
          return ListTile(
            title: Container(
              padding: const EdgeInsets.only(
                bottom: 10,
                top: 10,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: fipeColorPalette.shade50,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    widget.names[index],
                    style: TextStyle(
                      color: fipeColorPalette.shade50,
                    ),
                  )),
                  const Spacer(),
                  FipeFlatButton(
                    text: "",
                    icon: Icons.close,
                    color: fipeColorPalette.shade100,
                    fn: () {
                      setState(() {
                        widget.onRemove(index);
                      });
                    },
                  ),
                ],
              ),
            ),
            style: ListTileStyle.list,
          );
        },
        itemCount: widget.names.length,
      ),
    );
  }
}
