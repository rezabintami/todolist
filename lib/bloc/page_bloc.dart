import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todolist/models/models.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(PageInitial());

  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is GoToLoginPage) {
      yield OnLoginPage();
    } else if (event is GoToLandingPage) {
      yield OnLandingPage();
    } else if (event is GoToOnBoardingPage) {
      yield OnOnBoardingPage();
    } else if (event is GoToFriendListPage) {
      yield OnFriendListPage();
    } else if (event is GoToProjectPage) {
      yield OnProjectPage();
    } else if (event is GoToBlankScreenPage) {
      yield OnBlankScreenPage();
      await Future.delayed(Duration(seconds: 1));
      yield OnOnBoardingPage();
    } else if (event is GoToProjectDetailPage) {
      yield OnProjectDetailPage(event.updatetask);
    } else if (event is GoToAddFriendPage) {
      yield OnAddFriendPage(event.name);
    }
  }
}
