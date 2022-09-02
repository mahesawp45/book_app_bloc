// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'newbook_bloc.dart';

class NewbookState extends Equatable {
  final Offset? dragStartDetails;
  final Offset? dragUpdateDetails;
  final Offset? dragEndPosition;
  const NewbookState({
    this.dragStartDetails,
    this.dragUpdateDetails,
    this.dragEndPosition,
  });

  @override
  List<Object> get props =>
      [dragStartDetails ?? 0, dragEndPosition ?? 0, dragUpdateDetails ?? 0];
}

class NewBookLoadingState extends NewbookState {}

class NewBookLoadedState extends NewbookState {
  final List<Books> books;

  final Offset? dragstartDetails;

  final Offset? dragupdateDetails;

  final Offset? dragendPosition;

  const NewBookLoadedState({
    required this.books,
    this.dragstartDetails,
    this.dragupdateDetails,
    this.dragendPosition,
  });

  @override
  List<Object> get props =>
      [books, dragendPosition!, dragstartDetails!, dragupdateDetails!];
}

class NewBookErrorState extends NewbookState {
  final String error;

  const NewBookErrorState({
    required this.error,
  });

  @override
  List<Object> get props => [error];
}

class NewBookStartPositionState extends NewbookState {
  final Offset dragstartDetails;
  const NewBookStartPositionState({
    required this.dragstartDetails,
  });

  @override
  List<Object> get props => [dragstartDetails];
}
