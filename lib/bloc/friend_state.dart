part of 'friend_bloc.dart';

abstract class FriendState {}

class FriendInitial extends FriendState {}

class FriendLoaded extends FriendState {
  List<FriendList> friend;
  FriendLoaded({this.friend});
  FriendLoaded copyWith({List<FriendList> friend}) {
    return FriendLoaded(
      friend: friend ?? this.friend,
    );
  }
}
