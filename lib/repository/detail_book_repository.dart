import 'dart:developer';
import 'dart:io';

import 'package:book_app_advance/response/detail_book_response.dart';
import 'package:book_app_advance/utils/base_url.dart';
import 'package:dio/dio.dart';

class DetailBookRepository {
  Dio _dioApi() {
    BaseOptions options = BaseOptions(
      baseUrl: BaseUrl.detailBookURL,
      headers: {
        HttpHeaders.contentTypeHeader:
            "application/json", // ini sama aja sama responseType di bawah
      },
      responseType: ResponseType.json,
    );

    final dio = Dio(options);
    return dio;
  }

  Future getDetailBook({required String isbn13}) async {
    final dio = _dioApi();

    Response response = await dio.get("${BaseUrl.detailBookURL}$isbn13");

    if (response.statusCode == 200) {
      var data = response.data as Map<String, dynamic>;

      log(data.toString());
      return DetailBook.fromJson(data);
    } else {
      throw Exception(response.statusCode);
    }
  }
}
