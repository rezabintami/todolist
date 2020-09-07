part of 'friendlist_bloc.dart';

abstract class FriendlistState {}

class FriendlistInitial extends FriendlistState {}

class FriendListLoaded extends FriendlistState {
  List<Friend> friend;
  FriendListLoaded({this.friend});
  FriendListLoaded copyWith({List<Friend> friend}) {
    return FriendListLoaded(
      friend: friend ?? this.friend,
    );
  }
}
