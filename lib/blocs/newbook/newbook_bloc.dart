// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:book_app_advance/repository/new_book_repository.dart';
import 'package:book_app_advance/response/new_book_response.dart';

part 'newbook_event.dart';
part 'newbook_state.dart';

class NewbookBloc extends Bloc<NewbookEvent, NewbookState> {
  NewBookRepository? newBookRepository;

  // Buat position
  Offset _position = Offset.zero;
  Offset get position => _position;

  NewbookBloc({this.newBookRepository}) : super(NewBookLoadingState()) {
    on<NewBookLoadEvent>((event, emit) async {
      emit(NewBookLoadingState());

      try {
        final newbooks = await NewBookRepository().getNewBook();

        // ini bakal bisa muncul kalo udah dipanggil blocnya
        // log(newbooks.books.toString());

        emit(NewBookLoadedState(
          books: newbooks.books,
          dragstartDetails: state.dragStartDetails,
          dragupdateDetails: state.dragUpdateDetails,
          dragendPosition: state.dragEndPosition,
        ));
      } catch (e) {
        emit(NewBookErrorState(error: e.toString()));
      }
    });

    on<NewBookStartPositionEvent>(_onNewBookStartPosition);
    on<NewBookUpdatePositionEvent>(_onNewBookUpdatePosition);
    on<NewBookEndPositionEvent>(_onNewBookEndPosition);
  }

  _onNewBookStartPosition(
      NewBookStartPositionEvent event, Emitter<NewbookState> emit,
      {DragStartDetails? dragStart}) {
    emit(
      NewbookState(
        dragStartDetails: _position,
        dragUpdateDetails: state.dragUpdateDetails,
        dragEndPosition: state.dragEndPosition,
      ),
    );
    // var dragStartDetails = event.dragStartDetails;
  }

  _onNewBookUpdatePosition(
      NewBookUpdatePositionEvent event, Emitter<NewbookState> emit,
      {DragUpdateDetails? dragUpdate}) {
    var dragUpdateDetails = event.dragUpdateDetails;
    _position += dragUpdateDetails.delta;

    emit(
      NewbookState(
        dragUpdateDetails: _position,
        dragStartDetails: state.dragStartDetails,
        dragEndPosition: state.dragEndPosition,
      ),
    );
  }

  _onNewBookEndPosition(
      NewBookEndPositionEvent event, Emitter<NewbookState> emit,
      {DragUpdateDetails? dragUpdate}) {
    _position += Offset.zero;

    emit(
      NewbookState(
        dragUpdateDetails: state.dragUpdateDetails,
        dragStartDetails: state.dragStartDetails,
        dragEndPosition: _position,
      ),
    );
  }
}
