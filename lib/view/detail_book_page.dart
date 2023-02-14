// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:book_app_advance/blocs/blocs_export.dart';
import 'package:book_app_advance/repository/detail_book_repository.dart';
import 'package:book_app_advance/theme/border_style.dart';
import 'package:book_app_advance/view/home_page.dart';
import 'package:book_app_advance/widgets/app_bar_book.dart';

class DetailBookPage extends StatelessWidget {
  const DetailBookPage({
    Key? key,
    this.isbn13,
  }) : super(key: key);

  static const String route = '/detail-book';

  final String? isbn13;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => DetailBookBloc(
          detailBookRepository:
              RepositoryProvider.of<DetailBookRepository>(context),
          isbn13: isbn13 ?? '')
        ..add(DetailBookLoadEvent()),
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 50),
            AppBarBook(
              title: const Text(
                'Detail Book',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              colorButton: Colors.blue,
              iconButton: Icons.arrow_back,
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, HomePage.route, (route) => false);
              },
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_horiz_outlined, size: 30),
              ),
            ),
            BlocBuilder<DetailBookBloc, DetailBookState>(
              builder: (context, state) {
                /// Saat keadaan Loading data
                if (state is DetailBookLoadingState) {
                  return const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (state is DetailBookLoadedState) {
                  return Expanded(
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        DetailBookContentWidget(
                            height: height, width: width, state: state),
                        _buildImageDetailBook(height, state),
                        _buildAddToCart(height),
                      ],
                    ),
                  );
                }

                if (state is DetailBookErrorState) {
                  return Center(
                    child: Text(state.error),
                  );
                }

                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Container _buildAddToCart(double height) {
    return Container(
      height: height * 0.10,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.blue,
        border: MyBorderStyle.cuteBorder,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: MyBorderStyle.cuteBorder,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'QTY',
                    textAlign: TextAlign.center,
                  ),
                  const VerticalDivider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(
                          Icons.remove,
                          color: Colors.grey,
                          size: 15,
                        ),
                        SizedBox(width: 20),
                        Text('0',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                            )),
                        SizedBox(width: 20),
                        Icon(
                          Icons.add,
                          color: Colors.grey,
                          size: 15,
                        ),
                      ]),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: -1,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.amber,
                border: MyBorderStyle.cuteBorder,
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Text(
                'Add to Cart',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Positioned _buildImageDetailBook(double height, DetailBookLoadedState state) {
    return Positioned(
      top: 40,
      child: Container(
        height: height * 0.32,
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          border: MyBorderStyle.cuteBorder,
          borderRadius: BorderRadius.circular(10),
        ),
        child: CachedNetworkImage(
          imageUrl: state.detailBook.image ?? '',
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(
            value: downloadProgress.progress,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}

class DetailBookContentWidget extends StatelessWidget {
  const DetailBookContentWidget({
    Key? key,
    required this.height,
    required this.width,
    required this.state,
  }) : super(key: key);

  final double height;
  final double width;
  final DetailBookLoadedState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.60,
      width: width,
      decoration: BoxDecoration(
        border: MyBorderStyle.cuteBorder,
        borderRadius: MyBorderStyle.cuteRadius,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            _buildPriceTitleAuthorsDetailBook(),
            const SizedBox(height: 20),
            _buildPanelDetailBook(),
            const SizedBox(height: 20),
            (state.detailBook.desc != '')
                ? _buildDescDetailBook(context)
                : const Expanded(
                    child: SizedBox(
                      child: Center(child: Text('No Descriptions..')),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Column _buildDescDetailBook(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          state.detailBook.desc!,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          child: const Text(
            'Read More..',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationThickness: 2,
            ),
          ),
          onTap: () {
            showModalBottomSheet(
              backgroundColor: Colors.amber,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                side: BorderSide(color: Colors.black, width: 2),
              ),
              context: context,
              builder: (context) {
                return SizedBox(
                  height: height * 0.5,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 30),
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          height: 5,
                          decoration: BoxDecoration(
                            border: MyBorderStyle.cuteBorder,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          margin: const EdgeInsets.only(
                              bottom: 20, left: 120, right: 120),
                        ),
                      ),
                      Text(state.detailBook.desc ?? ''),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Container _buildPanelDetailBook() {
    return Container(
      height: height * 0.09,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      decoration: BoxDecoration(
        border: MyBorderStyle.cuteBorder,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildItemPanelDetailBook(
              content: state.detailBook.rating, label: 'Rating'),
          const VerticalDivider(
            color: Colors.black,
            thickness: 2,
          ),
          _buildItemPanelDetailBook(
              flex: 2,
              content: "${state.detailBook.pages} Page",
              label: 'Number of pages'),
          const VerticalDivider(
            color: Colors.black,
            thickness: 2,
          ),
          _buildItemPanelDetailBook(
              content:
                  "${state.detailBook.language?.substring(0, 3).toUpperCase()}",
              label: 'Language'),
        ],
      ),
    );
  }

  Widget _buildItemPanelDetailBook(
      {required String? content, required String label, int? flex}) {
    return Expanded(
      flex: flex ?? 1,
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                ),
              ),
            ),
            Expanded(
              child: Text(
                content ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _buildPriceTitleAuthorsDetailBook() {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(height: 130),
          Text(
            state.detailBook.price ?? '',
            style: const TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            state.detailBook.title ?? '',
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            state.detailBook.authors ?? '',
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
