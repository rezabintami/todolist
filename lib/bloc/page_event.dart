part of 'page_bloc.dart';

@immutable
abstract class PageEvent {}

class GoToLoginPage extends PageEvent {}

class GoToLandingPage extends PageEvent {}

class GoToProjectPage extends PageEvent {}

class GoToProjectDetailPage extends PageEvent {
  final UpdateTask updatetask;
  GoToProjectDetailPage(this.updatetask);
}

class GoToOnBoardingPage extends PageEvent {}

class GoToFriendListPage extends PageEvent {}

class GoToAddFriendPage extends PageEvent {
  final String name;
  GoToAddFriendPage(this.name);
}
