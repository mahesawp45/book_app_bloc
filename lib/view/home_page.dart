import 'dart:developer';

import 'package:book_app_advance/theme/border_style.dart';
import 'package:book_app_advance/widgets/book_image_widget.dart';
import 'package:book_app_advance/widgets/mini_bar_book.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:book_app_advance/blocs/newbook/newbook_bloc.dart';
import 'package:book_app_advance/widgets/app_bar_book.dart';
import 'package:book_app_advance/widgets/search_bar_book.dart';

final ZoomDrawerController z = ZoomDrawerController();

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40),
          AppBarBook(
            colorButton: Colors.redAccent,
            iconButton: Icons.dashboard_rounded,
            onTap: () {
              z.toggle!();
            },
            trailing: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_bag_outlined),
                ),
                const CircleAvatar(
                    backgroundColor: Colors.redAccent,
                    child: Icon(Icons.person, color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          SearchBarBook(width: width, height: height),
          const SizedBox(height: 30),
          Expanded(
            child: Container(
              width: width,
              decoration: BoxDecoration(
                color: Colors.blue.shade400,
                border: MyBorderStyle.cuteBorder,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: -50,
                    left: -50,
                    child: Container(
                      height: height * 0.2,
                      width: width * 0.5,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -50,
                    right: -50,
                    child: Container(
                      height: height * 0.3,
                      width: width * 0.7,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(200),
                      ),
                    ),
                  ),
                  ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      const MiniBarBook(
                        color: Colors.white,
                        label: 'Trending Book',
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<NewbookBloc, NewbookState>(
                        builder: (context, state) {
                          if (state is NewBookLoadingState) {
                            return const SizedBox(
                              height: 260,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }

                          if (state is NewBookLoadedState) {
                            log(state.dragUpdateDetails.toString());
                            var data = state.books;

                            return Container(
                              padding: const EdgeInsets.only(left: 20),
                              height: 260,
                              child: ListView.builder(
                                padding: const EdgeInsets.only(left: 20),
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return BookImageWidget(
                                    data: data,
                                    index: index,
                                    isbn13: data[index].isbn13 ?? '',
                                  );
                                },
                              ),
                            );

                            // return AnimatedContainer(
                            // curve: Curves.easeInOut,
                            // duration: const Duration(milliseconds: 0),
                            // transform: Matrix4.identity()..translate(0),
                            //   child: BookImageWidget(data: data, index: 0),
                            // );
                          }

                          if (state is NewBookErrorState) {
                            return const Center(
                              child: Text('error'),
                            );
                          }

                          return Container();
                        },
                      ),
                      const SizedBox(height: 25),
                      Container(
                        height: height * 0.3,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: MyBorderStyle.cuteBorder,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 15),
                            const MiniBarBook(
                              color: Colors.black,
                              label: 'Continue Reading',
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                dashPattern: const [5, 4],
                                radius: const Radius.circular(50),
                                color: Colors.black,
                                strokeWidth: 2,
                                child: Container(
                                  height: height * 0.07,
                                  width: width * 0.8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              height: height * 0.065,
                              width: width * 0.8,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.redAccent,
                                border:
                                    Border.all(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        border: Border.all(
                                            color: Colors.black, width: 2),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Expanded(child: Icon(Icons.storage)),
                                          Expanded(child: Text('Explore')),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 40),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.book,
                                            color: Colors.white,
                                          )),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.system_update_tv,
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Zoom extends StatelessWidget {
  const Zoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: z,
      borderRadius: 24,
      style: DrawerStyle.defaultStyle,
      showShadow: true,
      openCurve: Curves.fastOutSlowIn,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      mainScreenTapClose: true,
      duration: const Duration(milliseconds: 500),
      angle: 0.0,
      menuBackgroundColor: Colors.blue,
      mainScreen: const Body(),
      menuScreen: Theme(
        data: ThemeData.dark(),
        child: const Scaffold(
          backgroundColor: Colors.blue,
          body: Padding(
            padding: EdgeInsets.only(left: 25),
            child: Center(
              child: Text(
                'Test',
                // style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TwoPanels(),
    );
  }
}

class TwoPanels extends StatelessWidget {
  // final AnimationController controller;

  const TwoPanels({
    Key? key,
  }) : super(key: key);

  Widget bothPanels(BuildContext context, BoxConstraints constraints) {
    return Stack(
      children: const <Widget>[
        HomePage(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: bothPanels,
    );
  }
}
