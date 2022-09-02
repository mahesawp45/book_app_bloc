// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'newbook_bloc.dart';

abstract class NewbookEvent extends Equatable {
  const NewbookEvent();

  @override
  List<Object> get props => [];
}

class NewBookLoadEvent extends NewbookEvent {}

class NewBookStartPositionEvent extends NewbookEvent {
  final DragStartDetails? dragStartDetails;

  const NewBookStartPositionEvent({
    this.dragStartDetails,
  });

  @override
  List<Object> get props => [dragStartDetails ?? 0];
}

class NewBookUpdatePositionEvent extends NewbookEvent {
  final DragUpdateDetails dragUpdateDetails;
  const NewBookUpdatePositionEvent({
    required this.dragUpdateDetails,
  });

  @override
  List<Object> get props => [dragUpdateDetails];
}

class NewBookEndPositionEvent extends NewbookEvent {
  final DragEndDetails dragEndDetails;
  const NewBookEndPositionEvent({
    required this.dragEndDetails,
  });

  @override
  List<Object> get props => [dragEndDetails];
}
