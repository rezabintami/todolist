part of 'project_bloc.dart';

abstract class ProjectState {}

class ProjectInitial extends ProjectState {}

class ProjectLoaded extends ProjectState {
  List<GetTask> getTask;
  ProjectLoaded({this.getTask});
  ProjectLoaded copyWith({List<GetTask> getTask}) {
    return ProjectLoaded(
      getTask: getTask ?? this.getTask,
    );
  }
}
