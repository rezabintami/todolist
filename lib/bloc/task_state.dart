part of 'task_bloc.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskLoaded extends TaskState {
  List<GetTask> getTask;
  TaskLoaded({this.getTask});
  TaskLoaded copyWith({List<GetTask> getTask}) {
    return TaskLoaded(
      getTask: getTask ?? this.getTask,
    );
  }
}
