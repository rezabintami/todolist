import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todolist/bloc/blocs.dart';
import 'package:todolist/models/models.dart';
import 'package:todolist/services/services.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial());

  @override
  Stream<TaskState> mapEventToState(
    TaskEvent event,
  ) async* {
    if (event is GetAllTask) {
      List<GetTask> getTask;
      getTask = await TaskServices.getall();
      yield TaskLoaded(getTask: getTask);
    } else if (event is ReturnAllTask) {
      yield TaskInitial();
    }
  }
}
