// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'detail_book_bloc.dart';

abstract class DetailBookState extends Equatable {
  const DetailBookState();

  @override
  List<Object> get props => [];
}

class DetailBookLoadingState extends DetailBookState {}

class DetailBookLoadedState extends DetailBookState {
  final DetailBook detailBook;

  const DetailBookLoadedState({required this.detailBook});
  @override
  List<Object> get props => [detailBook];
}

class DetailBookErrorState extends DetailBookState {
  final String error;
  const DetailBookErrorState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}
