import 'package:flutter/material.dart';

class DetailsRow extends StatelessWidget {
  final String name;
  final String detail;
  final IconData icon;

  const DetailsRow(
      {Key? key, required this.name, required this.detail, required this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon),
        SizedBox(
          width: 3,
        ),
        Text(name),
        SizedBox(
          width: 20,
        ),
        Flexible(
          child: Column(
            children: [
              Text(
                detail,
              ),
            ],
          ),
        )
      ],
    );
  }
}
