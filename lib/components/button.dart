import 'package:fipe_app/components/divider.dart';
import 'package:fipe_app/theme/colors.dart';
import 'package:flutter/material.dart';

class FipeButton extends StatelessWidget {
  final String text;
  final Function() fn;
  final Color? color;
  final IconData? icon;

  const FipeButton({
    required this.text,
    required this.fn,
    this.icon,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: fn,
      style: TextButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).primaryColor,
        primary: luminanceColor(color ?? Theme.of(context).primaryColor),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon != null
              ? Icon(
                  icon,
                  size: 20,
                )
              : Container(),
          icon != null && text.isNotEmpty
              ? const DividerSpace(
                  size: 5,
                  isWidth: true,
                )
              : Container(),
          Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class FipeFlatButton extends StatelessWidget {
  final String text;
  final Function() fn;
  final Color? color;
  final IconData? icon;

  const FipeFlatButton({
    required this.text,
    required this.fn,
    this.icon,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: fn,
      style: TextButton.styleFrom(
        primary: color ?? Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 20,
          ),
          icon != null && text.isNotEmpty
              ? const DividerSpace(
                  size: 5,
                  isWidth: true,
                )
              : Container(),
          Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
