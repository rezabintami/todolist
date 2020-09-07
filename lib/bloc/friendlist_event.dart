part of 'friendlist_bloc.dart';

abstract class FriendlistEvent {}

class GetFriendList extends FriendlistEvent {
  String id;
  GetFriendList(this.id);
}

class ReturnFriendList extends FriendlistEvent {}
