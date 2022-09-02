// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:book_app_advance/view/detail_book_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:book_app_advance/response/new_book_response.dart';
import 'package:book_app_advance/theme/border_style.dart';

class BookImageWidget extends StatelessWidget {
  const BookImageWidget({
    Key? key,
    required this.data,
    required this.index,
    this.isbn13,
  }) : super(key: key);

  final List<Books> data;
  final int index;
  final String? isbn13;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // var h = context.read<NewbookBloc>().position;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return DetailBookPage(isbn13: isbn13);
          }),
        );
      },
      child: Container(
        width: size.width * 0.4,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.4),
          border: MyBorderStyle.cuteBorder,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: "${data[index].image}",
              fit: BoxFit.contain,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(
                      value: downloadProgress.progress, color: Colors.white),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: const Offset(0, -1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        '${data[index].price}',
                        style: TextStyle(
                          color: Colors.grey.shade800,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "${data[index].title}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onPanStart: (details) {
        // context.read<NewbookBloc>().add(
        //       NewBookStartPositionEvent(dragStartDetails: details),
        //     );
      },
      onPanUpdate: (details) {
        // context.read<NewbookBloc>().add(
        //       NewBookUpdatePositionEvent(dragUpdateDetails: details),
        //     );

        // log(h.position.toString());
      },
      onPanEnd: (details) {
        // context.read<NewbookBloc>().add(
        //       NewBookEndPositionEvent(dragEndDetails: details),
        //     );
      },
    );
  }
}
