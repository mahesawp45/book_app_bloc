import 'package:book_app_advance/theme/border_style.dart';
import 'package:flutter/material.dart';

class MoreButtonBook extends StatelessWidget {
  const MoreButtonBook({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              border: MyBorderStyle.cuteBorder,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Positioned(
            top: -3,
            left: -3,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                border: MyBorderStyle.cuteBorder,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_forward, size: 15),
            ),
          ),
        ],
      ),
    );
  }
}
