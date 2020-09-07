part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class LoadUser extends UserEvent {
  final String id;
  LoadUser(this.id);
}

class SignOut extends UserEvent {}
