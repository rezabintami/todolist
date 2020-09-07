part of 'project_bloc.dart';

abstract class ProjectEvent {}

class GetAllProject extends ProjectEvent {
  final String group;
  GetAllProject(this.group);
}

class ReturnProject extends ProjectEvent {}
