import 'package:flutter/material.dart';

import 'package:book_app_advance/theme/border_style.dart';

class AppBarBook extends StatelessWidget {
  const AppBarBook({
    Key? key,
    required this.colorButton,
    this.title,
    required this.trailing,
    required this.iconButton,
    required this.onTap,
  }) : super(key: key);

  final Color colorButton;
  final Widget? title;
  final Widget trailing;
  final IconData iconButton;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
                color: colorButton,
                borderRadius: BorderRadius.circular(100),
                border: MyBorderStyle.cuteBorder),
            child: IconButton(
              icon: Icon(iconButton, color: Colors.white),
              onPressed: onTap,
            ),
          ),

          /// Widget ditengah
          title ?? Container(),
          trailing,
        ],
      ),
    );
  }
}
