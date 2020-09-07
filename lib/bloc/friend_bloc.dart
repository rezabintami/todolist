import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todolist/models/models.dart';
import 'package:todolist/services/services.dart';

part 'friend_event.dart';
part 'friend_state.dart';

class FriendBloc extends Bloc<FriendEvent, FriendState> {
  FriendBloc() : super(FriendInitial());

  @override
  Stream<FriendState> mapEventToState(
    FriendEvent event,
  ) async* {
    if (event is GetFriend) {
      List<FriendList> friend;
      friend = await FriendServices.getall(event.name);
      yield FriendLoaded(friend: friend);
    } else if (event is ReturnFriend) {
      yield FriendInitial();
    }
  }
}
