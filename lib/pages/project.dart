part of 'pages.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<ProjectBloc>().add(ReturnProject());
        context.bloc<TaskBloc>().add(GetAllTask());
        context.bloc<PageBloc>().add(GoToLandingPage());
        return;
      },
      child: Scaffold(
        appBar: emptyAppbar(context),
        body: Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: BlocBuilder<ProjectBloc, ProjectState>(
              builder: (context, state) {
                if (state is ProjectInitial) {
                  return Container(
                    child: Center(child: Text("Loading..")),
                  );
                } else {
                  ProjectLoaded loaded = state as ProjectLoaded;
                  if (loaded.getTask.length == 0) {
                    return Container(
                        child: Center(child: Text("To Do List no Found")));
                  } else {
                    DateFormat dt2 = DateFormat("yyyy-MM-dd");
                    DateTime d1 = new DateTime.now();
                    DateTime tommorow = DateTime(d1.year, d1.month, d1.day + 1);
                    String besok = dt2.format(tommorow);
                    String sekarang = dt2.format(d1);
                    int now = d1.millisecondsSinceEpoch;
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: 15, left: 20, bottom: 15),
                              child: Text(
                                'Today',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: CustomColors.TextSubHeader),
                              ),
                            ),
                            SizedBox(height: 5),
                            Column(
                                children: loaded.getTask.map((e) {
                              if (e.date == sekarang) {
                                String tanggal = e.date + " " + e.time;
                                int estimasi = DateTime.parse(tanggal)
                                    .millisecondsSinceEpoch;
                                return Slidable(
                                  actionPane: SlidableDrawerActionPane(),
                                  actionExtentRatio: 0.12,
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
                                    padding: EdgeInsets.fromLTRB(5, 13, 5, 13),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        (now > estimasi)
                                            ? Image.asset(
                                                'assets/images/checked.png')
                                            : Image.asset(
                                                'assets/images/checked-empty.png'),
                                        Text(
                                          e.time,
                                          style: TextStyle(
                                              color: CustomColors.TextGrey),
                                        ),
                                        Container(
                                          width: 180,
                                          child: Text(
                                            e.name,
                                            style: (now > estimasi)
                                                ? TextStyle(
                                                    color:
                                                        CustomColors.TextGrey,
                                                    //fontWeight: FontWeight.w600,
                                                    decoration: TextDecoration
                                                        .lineThrough)
                                                : TextStyle(
                                                    color:
                                                        CustomColors.TextHeader,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        ),
                                        Image.asset(
                                            'assets/images/bell-small.png'),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        stops: [0.015, 0.015],
                                        colors: [
                                          CustomColors.GreenIcon,
                                          Colors.white
                                        ],
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.0),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: CustomColors.GreyBorder,
                                          blurRadius: 10.0,
                                          spreadRadius: 5.0,
                                          offset: Offset(0.0, 0.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                  secondaryActions: <Widget>[
                                    SlideAction(
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: CustomColors
                                                    .TrashRedBackground),
                                            child: Icon(Icons.add,
                                                color: Colors.red)),
                                      ),
                                      onTap: () async {
                                        UpdateTask getTask = UpdateTask();
                                        getTask.name = e.name;
                                        getTask.group = e.group;
                                        getTask.date = e.date;
                                        getTask.time = e.time;
                                        getTask.id = e.id;
                                        SharedPreferences preferences =
                                            await SharedPreferences
                                                .getInstance();
                                        context.bloc<FriendlistBloc>().add(
                                            GetFriendList(preferences
                                                .getString("account_id")));
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                  contentPadding:
                                                      EdgeInsets.all(0.0),
                                                  title: Center(
                                                    child: Text("Share Task"),
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0))),
                                                  content: Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.75,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.9,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10),
                                                    child: BlocBuilder<
                                                        FriendlistBloc,
                                                        FriendlistState>(
                                                      builder:
                                                          (context, state) {
                                                        if (state
                                                            is FriendlistInitial) {
                                                          return Container();
                                                        } else {
                                                          FriendListLoaded
                                                              loaded = state
                                                                  as FriendListLoaded;
                                                          return ListView
                                                              .builder(
                                                            itemCount: loaded
                                                                .friend.length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return InkWell(
                                                                onTap:
                                                                    () async {
                                                                  print(loaded
                                                                      .friend[
                                                                          index]
                                                                      .id);
                                                                  await TaskServices.sharedTask(
                                                                      getTask,
                                                                      loaded
                                                                          .friend[
                                                                              index]
                                                                          .id);
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          20.0,
                                                                      vertical:
                                                                          10.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Container(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.6,
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                                              child: Image.asset('assets/images/photo.png'),
                                                                            ),
                                                                            Text(loaded.friend[index].name,
                                                                                style: TextStyle(fontSize: 15))
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ));
                                            });
                                      },
                                    ),
                                    SlideAction(
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: CustomColors
                                                    .TrashRedBackground),
                                            child: Icon(Icons.edit,
                                                color: Colors.red)),
                                      ),
                                      onTap: () async {
                                        UpdateTask updatetask = UpdateTask();
                                        updatetask.name = e.name;
                                        updatetask.group = e.group;
                                        updatetask.date = e.date;
                                        updatetask.time = e.time;
                                        updatetask.id = e.id;
                                        context.bloc<PageBloc>().add(
                                            GoToProjectDetailPage(updatetask));
                                      },
                                    ),
                                    SlideAction(
                                      child: Container(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: CustomColors
                                                  .TrashRedBackground),
                                          child: Image.asset(
                                              'assets/images/trash.png'),
                                        ),
                                      ),
                                      onTap: () async {
                                        GetTask getTask = GetTask();
                                        getTask.name = e.name;
                                        getTask.group = e.group;
                                        getTask.date = e.date;
                                        getTask.time = e.time;
                                        getTask.id = e.id;
                                        await TaskServices.deleteTask(getTask);
                                        context
                                            .bloc<ProjectBloc>()
                                            .add(ReturnProject());
                                        context
                                            .bloc<ProjectBloc>()
                                            .add(GetAllProject(getTask.group));
                                      },
                                    ),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            }).toList()),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 15, left: 20, bottom: 15),
                              child: Text(
                                'Tomorrow',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: CustomColors.TextSubHeader),
                              ),
                            ),
                            SizedBox(height: 5),
                            Column(
                                children: loaded.getTask
                                    .map((e) => (e.date == besok)
                                        ? Slidable(
                                            actionPane:
                                                SlidableDrawerActionPane(),
                                            actionExtentRatio: 0.12,
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  20, 0, 20, 15),
                                              padding: EdgeInsets.fromLTRB(
                                                  5, 13, 5, 13),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Image.asset(
                                                      'assets/images/checked-empty.png'),
                                                  Text(
                                                    e.time,
                                                    style: TextStyle(
                                                        color: CustomColors
                                                            .TextGrey),
                                                  ),
                                                  Container(
                                                    width: 180,
                                                    child: Text(
                                                      e.name,
                                                      style: TextStyle(
                                                          color: CustomColors
                                                              .TextHeader,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  Image.asset(
                                                      'assets/images/bell-small.png'),
                                                ],
                                              ),
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  stops: [0.015, 0.015],
                                                  colors: [
                                                    CustomColors.GreenIcon,
                                                    Colors.white
                                                  ],
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        CustomColors.GreyBorder,
                                                    blurRadius: 10.0,
                                                    spreadRadius: 5.0,
                                                    offset: Offset(0.0, 0.0),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            secondaryActions: <Widget>[
                                              SlideAction(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Container(
                                                      height: 35,
                                                      width: 35,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: CustomColors
                                                              .TrashRedBackground),
                                                      child: Icon(Icons.add,
                                                          color: Colors.red)),
                                                ),
                                                onTap: () async {
                                                  UpdateTask getTask =
                                                      UpdateTask();
                                                  getTask.name = e.name;
                                                  getTask.group = e.group;
                                                  getTask.date = e.date;
                                                  getTask.time = e.time;
                                                  getTask.id = e.id;
                                                  SharedPreferences
                                                      preferences =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  context
                                                      .bloc<FriendlistBloc>()
                                                      .add(GetFriendList(
                                                          preferences.getString(
                                                              "account_id")));
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    0.0),
                                                            title: Center(
                                                              child: Text(
                                                                  "Share Task"),
                                                            ),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10.0))),
                                                            content: Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.75,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.9,
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          10),
                                                              child: BlocBuilder<
                                                                  FriendlistBloc,
                                                                  FriendlistState>(
                                                                builder:
                                                                    (context,
                                                                        state) {
                                                                  if (state
                                                                      is FriendlistInitial) {
                                                                    return Container();
                                                                  } else {
                                                                    FriendListLoaded
                                                                        loaded =
                                                                        state
                                                                            as FriendListLoaded;
                                                                    return ListView
                                                                        .builder(
                                                                      itemCount: loaded
                                                                          .friend
                                                                          .length,
                                                                      itemBuilder:
                                                                          (BuildContext context,
                                                                              int index) {
                                                                        return InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            print(loaded.friend[index].id);
                                                                            await TaskServices.sharedTask(getTask,
                                                                                loaded.friend[index].id);
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Container(
                                                                                  width: MediaQuery.of(context).size.width * 0.6,
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                                                        child: Image.asset('assets/images/photo.png'),
                                                                                      ),
                                                                                      Text(loaded.friend[index].name, style: TextStyle(fontSize: 15))
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                    );
                                                                  }
                                                                },
                                                              ),
                                                            ));
                                                      });
                                                },
                                              ),
                                              SlideAction(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Container(
                                                      height: 35,
                                                      width: 35,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(50),
                                                          color: CustomColors
                                                              .TrashRedBackground),
                                                      child: Icon(Icons.edit,
                                                          color: Colors.red)),
                                                ),
                                                onTap: () async {
                                                  UpdateTask updatetask =
                                                      UpdateTask();
                                                  updatetask.name = e.name;
                                                  updatetask.group = e.group;
                                                  updatetask.date = e.date;
                                                  updatetask.time = e.time;
                                                  updatetask.id = e.id;
                                                  context.bloc<PageBloc>().add(
                                                      GoToProjectDetailPage(
                                                          updatetask));
                                                },
                                              ),
                                              SlideAction(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      bottom: 10),
                                                  child: Container(
                                                    height: 35,
                                                    width: 35,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color: CustomColors
                                                            .TrashRedBackground),
                                                    child: Image.asset(
                                                        'assets/images/trash.png'),
                                                  ),
                                                ),
                                                onTap: () async {
                                                  GetTask getTask = GetTask();
                                                  getTask.name = e.name;
                                                  getTask.group = e.group;
                                                  getTask.date = e.date;
                                                  getTask.time = e.time;
                                                  getTask.id = e.id;
                                                  await TaskServices.deleteTask(
                                                      getTask);
                                                  context
                                                      .bloc<ProjectBloc>()
                                                      .add(ReturnProject());
                                                  context
                                                      .bloc<ProjectBloc>()
                                                      .add(GetAllProject(
                                                          getTask.group));
                                                },
                                              ),
                                            ],
                                          )
                                        : Container())
                                    .toList()),
                          ],
                        ));
                  }
                }
              },
            )),
      ),
    );
  }
}
