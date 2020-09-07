part of 'friend_bloc.dart';

abstract class FriendEvent {}

class GetFriend extends FriendEvent {
  String name;
  GetFriend(this.name);
}

class ReturnFriend extends FriendEvent {}
