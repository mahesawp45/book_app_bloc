import 'package:book_app_advance/theme/border_style.dart';
import 'package:flutter/material.dart';

class SearchBarBook extends StatelessWidget {
  const SearchBarBook({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: width * 0.80,
          height: height * 0.06,
          decoration: BoxDecoration(
            color: Colors.amber,
            border: MyBorderStyle.cuteBorder,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        Positioned(
          left: -4,
          top: -7,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            width: width * 0.80,
            height: height * 0.06,
            decoration: BoxDecoration(
              color: Colors.white,
              border: MyBorderStyle.cuteBorder,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(children: const [
              Expanded(
                child: TextField(
                  cursorColor: Colors.redAccent,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 20),
                    hintText: 'Search',
                    border: InputBorder.none,
                  ),
                ),
              ),
              VerticalDivider(thickness: 2, color: Colors.black),
              Icon(Icons.mic),
            ]),
          ),
        ),
      ],
    );
  }
}
