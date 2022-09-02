// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:book_app_advance/widgets/more_button_book.dart';

class MiniBarBook extends StatelessWidget {
  const MiniBarBook({
    Key? key,
    required this.color,
    required this.label,
  }) : super(key: key);

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          label,
          style: TextStyle(color: color),
        ),
        MoreButtonBook(onTap: () {}),
      ]),
    );
  }
}
