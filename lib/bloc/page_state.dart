part of 'page_bloc.dart';

@immutable
abstract class PageState {}

class PageInitial extends PageState {}

class OnLoginPage extends PageState {}

class OnLandingPage extends PageState {}

class OnProjectPage extends PageState {}

class OnProjectDetailPage extends PageState {
  final UpdateTask updatetask;
  OnProjectDetailPage(this.updatetask);
}

class OnOnBoardingPage extends PageState {}

class OnFriendListPage extends PageState {}

class OnAddFriendPage extends PageState {
  final String name;
  OnAddFriendPage(this.name);
}
