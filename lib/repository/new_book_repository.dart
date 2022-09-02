import 'dart:io';

import 'package:book_app_advance/response/new_book_response.dart';
import 'package:book_app_advance/utils/base_url.dart';
import 'package:dio/dio.dart';

class NewBookRepository {
  Dio _dioAPI() {
    BaseOptions options = BaseOptions(
      baseUrl: BaseUrl.bookURL,
      headers: {
        HttpHeaders.contentTypeHeader:
            "application/json", // ini sama aja sama responseType di bawah
      },
      responseType: ResponseType.json,
    );

    final dio = Dio(options);
    return dio;
  }

  Future getNewBook() async {
    var dio = _dioAPI();
    Response response = await dio.get(BaseUrl.newBookURL);

    if (response.statusCode == 200) {
      var data = response.data as Map<String, dynamic>;

      return NewBook.fromJson(data);
    } else {
      throw Exception(response.statusCode);
    }
  }
}
