import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todolist/models/models.dart';
import 'package:todolist/services/services.dart';

part 'friendlist_event.dart';
part 'friendlist_state.dart';

class FriendlistBloc extends Bloc<FriendlistEvent, FriendlistState> {
  FriendlistBloc() : super(FriendlistInitial());

  @override
  Stream<FriendlistState> mapEventToState(
    FriendlistEvent event,
  ) async* {
    if (event is GetFriendList) {
      List<Friend> friend;
      friend = await FriendListServices.getall(event.id);
      yield FriendListLoaded(friend: friend);
    } else if (event is ReturnFriendList) {
      yield FriendlistInitial();
    }
  }
}
