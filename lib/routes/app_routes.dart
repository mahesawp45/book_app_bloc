import 'package:book_app_advance/view/404.dart';
import 'package:book_app_advance/view/detail_book_page.dart';
import 'package:book_app_advance/view/home_page.dart';

import 'package:flutter/material.dart';

class APPRoutes {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.route:
        return MaterialPageRoute(
          builder: (context) {
            return const Zoom();
          },
        );
      case DetailBookPage.route:
        return MaterialPageRoute(
          builder: (context) {
            return const DetailBookPage();
          },
        );

      default:
        return MaterialPageRoute(
          builder: (context) {
            return const Error404Page();
          },
        );
    }
  }
}
