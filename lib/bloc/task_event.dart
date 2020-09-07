part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class GetAllTask extends TaskEvent {}

class ReturnAllTask extends TaskEvent {}
