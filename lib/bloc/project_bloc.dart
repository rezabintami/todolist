import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todolist/bloc/blocs.dart';
import 'package:todolist/models/models.dart';
import 'package:todolist/services/services.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc() : super(ProjectInitial());

  @override
  Stream<ProjectState> mapEventToState(
    ProjectEvent event,
  ) async* {
    if (event is GetAllProject) {
      List<GetTask> getTask;
      if (event.group == "Personal") {
        getTask = await ProjectServices.getallpersonal(event.group);
      } else if (event.group == "Work") {
        getTask = await ProjectServices.getallwork(event.group);
      } else if (event.group == "Meeting") {
        getTask = await ProjectServices.getallmeeting(event.group);
      } else if (event.group == "Study") {
        getTask = await ProjectServices.getallstudy(event.group);
      } else if (event.group == "Shopping") {
        getTask = await ProjectServices.getallshopping(event.group);
      } else if (event.group == "Party") {
        getTask = await ProjectServices.getallparty(event.group);
      }
      yield ProjectLoaded(getTask: getTask);
    } else if (event is ReturnProject) {
      yield ProjectInitial();
    }
  }
}
