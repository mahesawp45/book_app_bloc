part of 'detail_book_bloc.dart';

abstract class DetailBookEvent extends Equatable {
  const DetailBookEvent();

  @override
  List<Object> get props => [];
}

class DetailBookLoadEvent extends DetailBookEvent {}
