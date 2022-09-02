// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:book_app_advance/repository/detail_book_repository.dart';
import 'package:book_app_advance/response/detail_book_response.dart';

part 'detail_book_event.dart';
part 'detail_book_state.dart';

class DetailBookBloc extends Bloc<DetailBookEvent, DetailBookState> {
  final DetailBookRepository detailBookRepository;
  final String isbn13;

  DetailBookBloc({
    required this.detailBookRepository,
    required this.isbn13,
  }) : super(DetailBookLoadingState()) {
    on<DetailBookLoadEvent>((event, emit) async {
      /// Ketika Kondisi Loading -> ditangani di Front End
      emit(DetailBookLoadingState());

      try {
        final data = await DetailBookRepository().getDetailBook(isbn13: isbn13);

        emit(DetailBookLoadedState(detailBook: data));
      } catch (e) {
        emit(
          DetailBookErrorState(error: e.toString()),
        );
      }
    });
  }
}
