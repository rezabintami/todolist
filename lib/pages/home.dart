part of 'pages.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final bottomNavigationBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: (!isHaveTask) ? fullAppbar(context) : emptyAppbar(context),
        body: Container(
          padding: EdgeInsets.only(bottom: 30),
          child: ListView(
            children: [
              BlocBuilder<TaskBloc, TaskState>(
                builder: (context, state) {
                  if (state is TaskInitial) {
                    return Container(
                      child: Center(child: Text("Loading..")),
                    );
                  } else {
                    TaskLoaded loaded = state as TaskLoaded;
                    DateFormat dt2 = DateFormat("yyyy-MM-dd");
                    DateTime d1 = new DateTime.now();
                    DateTime tommorow = DateTime(d1.year, d1.month, d1.day + 1);
                    String besok = dt2.format(tommorow);
                    String sekarang = dt2.format(d1);
                    int now = d1.millisecondsSinceEpoch;
                    return (loaded.getTask.length == 0)
                        ? Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    flex: 8,
                                    child: Hero(
                                      tag: 'Clipboard',
                                      child: Image.asset(
                                          'assets/images/Clipboard-empty.png'),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          'No tasks',
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500,
                                              color: CustomColors.TextHeader),
                                        ),
                                        SizedBox(height: 15),
                                        Text(
                                          'You have no tasks to do.',
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400,
                                              color: CustomColors.TextBody,
                                              fontFamily: 'opensans'),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(),
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(
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
                                      actionExtentRatio: 0.25,
                                      child: Container(
                                        margin:
                                            EdgeInsets.fromLTRB(20, 0, 20, 15),
                                        padding:
                                            EdgeInsets.fromLTRB(5, 13, 5, 13),
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
                                                        color: CustomColors
                                                            .TextGrey,
                                                        //fontWeight: FontWeight.w600,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough)
                                                    : TextStyle(
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
                                            padding:
                                                EdgeInsets.only(bottom: 10),
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
                                            await TaskServices.deleteTask(
                                                getTask);
                                            context
                                                .bloc<TaskBloc>()
                                                .add(ReturnAllTask());
                                            context
                                                .bloc<TaskBloc>()
                                                .add(GetAllTask());
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
                                                actionExtentRatio: 0.25,
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
                                                                  FontWeight
                                                                      .w600),
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
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(5.0),
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: CustomColors
                                                            .GreyBorder,
                                                        blurRadius: 10.0,
                                                        spreadRadius: 5.0,
                                                        offset:
                                                            Offset(0.0, 0.0),
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
                                                                    .circular(
                                                                        50),
                                                            color: CustomColors
                                                                .TrashRedBackground),
                                                        child: Image.asset(
                                                            'assets/images/trash.png'),
                                                      ),
                                                    ),
                                                    onTap: () async {
                                                      GetTask getTask =
                                                          GetTask();
                                                      getTask.name = e.name;
                                                      getTask.group = e.group;
                                                      getTask.date = e.date;
                                                      getTask.time = e.time;
                                                      getTask.id = e.id;
                                                      await TaskServices
                                                          .deleteTask(getTask);
                                                      context
                                                          .bloc<TaskBloc>()
                                                          .add(ReturnAllTask());
                                                      context
                                                          .bloc<TaskBloc>()
                                                          .add(GetAllTask());
                                                    },
                                                  ),
                                                ],
                                              )
                                            : Container())
                                        .toList()),
                              ],
                            )

                            // ListView.builder(
                            //     itemCount: loaded.getTask.length,
                            //     itemBuilder: (context, index) {
                            //       return Slidable(
                            //         actionPane: SlidableDrawerActionPane(),
                            //         actionExtentRatio: 0.25,
                            //         child: Container(
                            //           margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
                            //           padding: EdgeInsets.fromLTRB(5, 13, 5, 13),
                            //           child: Row(
                            //             mainAxisAlignment:
                            //                 MainAxisAlignment.spaceEvenly,
                            //             children: <Widget>[
                            //               Image.asset(
                            //                   'assets/images/checked-empty.png'),
                            //               Text(
                            //                 loaded.getTask[index].time,
                            //                 style: TextStyle(
                            //                     color: CustomColors.TextGrey),
                            //               ),
                            //               Container(
                            //                 width: 180,
                            //                 child: Text(
                            //                   loaded.getTask[index].name,
                            //                   style: TextStyle(
                            //                       color: CustomColors.TextHeader,
                            //                       fontWeight: FontWeight.w600),
                            //                 ),
                            //               ),
                            //               Image.asset('assets/images/bell-small.png'),
                            //             ],
                            //           ),
                            //           decoration: BoxDecoration(
                            //             gradient: LinearGradient(
                            //               stops: [0.015, 0.015],
                            //               colors: [
                            //                 CustomColors.GreenIcon,
                            //                 Colors.white
                            //               ],
                            //             ),
                            //             borderRadius: BorderRadius.all(
                            //               Radius.circular(5.0),
                            //             ),
                            //             boxShadow: [
                            //               BoxShadow(
                            //                 color: CustomColors.GreyBorder,
                            //                 blurRadius: 10.0,
                            //                 spreadRadius: 5.0,
                            //                 offset: Offset(0.0, 0.0),
                            //               ),
                            //             ],
                            //           ),
                            //         ),
                            //         secondaryActions: <Widget>[
                            //           SlideAction(
                            //             child: Container(
                            //               padding: EdgeInsets.only(bottom: 10),
                            //               child: Container(
                            //                 height: 35,
                            //                 width: 35,
                            //                 decoration: BoxDecoration(
                            //                     borderRadius:
                            //                         BorderRadius.circular(50),
                            //                     color:
                            //                         CustomColors.TrashRedBackground),
                            //                 child: Image.asset(
                            //                     'assets/images/trash.png'),
                            //               ),
                            //             ),
                            //             onTap: () async {
                            //               GetTask getTask = GetTask();
                            //               getTask.name = loaded.getTask[index].name;
                            //               getTask.group = loaded.getTask[index].group;
                            //               getTask.date = loaded.getTask[index].date;
                            //               getTask.time = loaded.getTask[index].time;
                            //               getTask.id = loaded.getTask[index].id;
                            //               await TaskServices.deleteTask(getTask);
                            //               context
                            //                   .bloc<TaskBloc>()
                            //                   .add(ReturnAllTask());
                            //               context.bloc<TaskBloc>().add(GetAllTask());
                            //             },
                            //           ),
                            //         ],
                            //       );
                            //     })

                            // ListView(
                            //   scrollDirection: Axis.vertical,
                            //   children: <Widget>[
                            //     Container(
                            //       margin:
                            //           EdgeInsets.only(top: 15, left: 20, bottom: 15),
                            //       child: Text(
                            //         'Today',
                            //         style: TextStyle(
                            //             fontSize: 13,
                            //             fontWeight: FontWeight.w600,
                            //             color: CustomColors.TextSubHeader),
                            //       ),
                            //     ),
                            //     // Container(
                            //     //   margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
                            //     //   padding: EdgeInsets.fromLTRB(5, 13, 5, 13),
                            //     //   child: Row(
                            //     //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //     //     children: <Widget>[
                            //     //       Image.asset('assets/images/checked.png'),
                            //     //       Text(
                            //     //         '07.00 AM',
                            //     //         style:
                            //     //             TextStyle(color: CustomColors.TextGrey),
                            //     //       ),
                            //     //       Container(
                            //     //         width: 180,
                            //     //         child: Text(
                            //     //           'Go jogging with Christin',
                            //     //           style: TextStyle(
                            //     //               color: CustomColors.TextGrey,
                            //     //               //fontWeight: FontWeight.w600,
                            //     //               decoration: TextDecoration.lineThrough),
                            //     //         ),
                            //     //       ),
                            //     //       Image.asset('assets/images/bell-small.png'),
                            //     //     ],
                            //     //   ),
                            //     //   decoration: BoxDecoration(
                            //     //     gradient: LinearGradient(
                            //     //       stops: [0.015, 0.015],
                            //     //       colors: [CustomColors.YellowIcon, Colors.white],
                            //     //     ),
                            //     //     borderRadius: BorderRadius.all(
                            //     //       Radius.circular(5.0),
                            //     //     ),
                            //     //     boxShadow: [
                            //     //       BoxShadow(
                            //     //         color: CustomColors.GreyBorder,
                            //     //         blurRadius: 10.0,
                            //     //         spreadRadius: 5.0,
                            //     //         offset: Offset(0.0, 0.0),
                            //     //       ),
                            //     //     ],
                            //     //   ),
                            //     // ),
                            //     // Slidable(
                            //     //   actionPane: SlidableDrawerActionPane(),
                            //     //   actionExtentRatio: 0.25,
                            //     //   child: Container(
                            //     //     margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
                            //     //     padding: EdgeInsets.fromLTRB(5, 13, 5, 13),
                            //     //     child: Row(
                            //     //       mainAxisAlignment:
                            //     //           MainAxisAlignment.spaceEvenly,
                            //     //       children: <Widget>[
                            //     //         Image.asset(
                            //     //             'assets/images/checked-empty.png'),
                            //     //         Text(
                            //     //           '08.00 AM',
                            //     //           style:
                            //     //               TextStyle(color: CustomColors.TextGrey),
                            //     //         ),
                            //     //         Container(
                            //     //           width: 180,
                            //     //           child: Text(
                            //     //             'Send project file',
                            //     //             style: TextStyle(
                            //     //                 color: CustomColors.TextHeader,
                            //     //                 fontWeight: FontWeight.w600),
                            //     //           ),
                            //     //         ),
                            //     //         Image.asset('assets/images/bell-small.png'),
                            //     //       ],
                            //     //     ),
                            //     //     decoration: BoxDecoration(
                            //     //       gradient: LinearGradient(
                            //     //         stops: [0.015, 0.015],
                            //     //         colors: [
                            //     //           CustomColors.GreenIcon,
                            //     //           Colors.white
                            //     //         ],
                            //     //       ),
                            //     //       borderRadius: BorderRadius.all(
                            //     //         Radius.circular(5.0),
                            //     //       ),
                            //     //       boxShadow: [
                            //     //         BoxShadow(
                            //     //           color: CustomColors.GreyBorder,
                            //     //           blurRadius: 10.0,
                            //     //           spreadRadius: 5.0,
                            //     //           offset: Offset(0.0, 0.0),
                            //     //         ),
                            //     //       ],
                            //     //     ),
                            //     //   ),
                            //     //   secondaryActions: <Widget>[
                            //     //     SlideAction(
                            //     //       child: Container(
                            //     //         padding: EdgeInsets.only(bottom: 10),
                            //     //         child: Container(
                            //     //           height: 35,
                            //     //           width: 35,
                            //     //           decoration: BoxDecoration(
                            //     //               borderRadius: BorderRadius.circular(50),
                            //     //               color: CustomColors.TrashRedBackground),
                            //     //           child:
                            //     //               Image.asset('assets/images/trash.png'),
                            //     //         ),
                            //     //       ),
                            //     //       onTap: () => print('Delete'),
                            //     //     ),
                            //     //   ],
                            //     // ),
                            //     // Container(
                            //     //   margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
                            //     //   padding: EdgeInsets.fromLTRB(5, 13, 5, 13),
                            //     //   child: Row(
                            //     //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //     //     children: <Widget>[
                            //     //       Image.asset('assets/images/checked-empty.png'),
                            //     //       Text(
                            //     //         '10.00 AM',
                            //     //         style:
                            //     //             TextStyle(color: CustomColors.TextGrey),
                            //     //       ),
                            //     //       Container(
                            //     //         width: 180,
                            //     //         child: Text(
                            //     //           'Meeting with client',
                            //     //           style: TextStyle(
                            //     //               color: CustomColors.TextHeader,
                            //     //               fontWeight: FontWeight.w600),
                            //     //         ),
                            //     //       ),
                            //     //       Image.asset(
                            //     //           'assets/images/bell-small-yellow.png'),
                            //     //     ],
                            //     //   ),
                            //     //   decoration: BoxDecoration(
                            //     //     gradient: LinearGradient(
                            //     //       stops: [0.015, 0.015],
                            //     //       colors: [CustomColors.PurpleIcon, Colors.white],
                            //     //     ),
                            //     //     borderRadius: BorderRadius.all(
                            //     //       Radius.circular(5.0),
                            //     //     ),
                            //     //     boxShadow: [
                            //     //       BoxShadow(
                            //     //         color: CustomColors.GreyBorder,
                            //     //         blurRadius: 10.0,
                            //     //         spreadRadius: 5.0,
                            //     //         offset: Offset(0.0, 0.0),
                            //     //       ),
                            //     //     ],
                            //     //   ),
                            //     // ),
                            //     // Container(
                            //     //   margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
                            //     //   padding: EdgeInsets.fromLTRB(5, 13, 5, 13),
                            //     //   child: Row(
                            //     //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //     //     children: <Widget>[
                            //     //       Image.asset('assets/images/checked-empty.png'),
                            //     //       Text(
                            //     //         '13.00 PM',
                            //     //         style:
                            //     //             TextStyle(color: CustomColors.TextGrey),
                            //     //       ),
                            //     //       Container(
                            //     //         width: 180,
                            //     //         child: Text(
                            //     //           'Email client',
                            //     //           style: TextStyle(
                            //     //               color: CustomColors.TextHeader,
                            //     //               fontWeight: FontWeight.w600),
                            //     //         ),
                            //     //       ),
                            //     //       Image.asset('assets/images/bell-small.png'),
                            //     //     ],
                            //     //   ),
                            //     //   decoration: BoxDecoration(
                            //     //     gradient: LinearGradient(
                            //     //       stops: [0.015, 0.015],
                            //     //       colors: [CustomColors.GreenIcon, Colors.white],
                            //     //     ),
                            //     //     borderRadius: BorderRadius.all(
                            //     //       Radius.circular(5.0),
                            //     //     ),
                            //     //     boxShadow: [
                            //     //       BoxShadow(
                            //     //         color: CustomColors.GreyBorder,
                            //     //         blurRadius: 10.0,
                            //     //         spreadRadius: 5.0,
                            //     //         offset: Offset(0.0, 0.0),
                            //     //       ),
                            //     //     ],
                            //     //   ),
                            //     // ),
                            //     // Container(
                            //     //   margin: EdgeInsets.only(left: 20, bottom: 15),
                            //     //   child: Text(
                            //     //     'Tomorrow',
                            //     //     style: TextStyle(
                            //     //         fontSize: 13,
                            //     //         fontWeight: FontWeight.w600,
                            //     //         color: CustomColors.TextSubHeader),
                            //     //   ),
                            //     // ),
                            //     // Container(
                            //     //   margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
                            //     //   padding: EdgeInsets.fromLTRB(5, 13, 5, 13),
                            //     //   child: Row(
                            //     //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //     //     children: <Widget>[
                            //     //       Image.asset('assets/images/checked-empty.png'),
                            //     //       Text(
                            //     //         '07.00 AM',
                            //     //         style:
                            //     //             TextStyle(color: CustomColors.TextGrey),
                            //     //       ),
                            //     //       Container(
                            //     //         width: 180,
                            //     //         child: Text(
                            //     //           'Morning yoga',
                            //     //           style: TextStyle(
                            //     //               color: CustomColors.TextHeader,
                            //     //               fontWeight: FontWeight.w600),
                            //     //         ),
                            //     //       ),
                            //     //       Image.asset('assets/images/bell-small.png'),
                            //     //     ],
                            //     //   ),
                            //     //   decoration: BoxDecoration(
                            //     //     gradient: LinearGradient(
                            //     //       stops: [0.015, 0.015],
                            //     //       colors: [CustomColors.YellowIcon, Colors.white],
                            //     //     ),
                            //     //     borderRadius: BorderRadius.all(
                            //     //       Radius.circular(5.0),
                            //     //     ),
                            //     //     boxShadow: [
                            //     //       BoxShadow(
                            //     //         color: CustomColors.GreyBorder,
                            //     //         blurRadius: 10.0,
                            //     //         spreadRadius: 5.0,
                            //     //         offset: Offset(0.0, 0.0),
                            //     //       ),
                            //     //     ],
                            //     //   ),
                            //     // ),
                            //     // Container(
                            //     //   margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
                            //     //   padding: EdgeInsets.fromLTRB(5, 13, 5, 13),
                            //     //   child: Row(
                            //     //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //     //     children: <Widget>[
                            //     //       Image.asset('assets/images/checked-empty.png'),
                            //     //       Text(
                            //     //         '08.00 AM',
                            //     //         style:
                            //     //             TextStyle(color: CustomColors.TextGrey),
                            //     //       ),
                            //     //       Container(
                            //     //         width: 180,
                            //     //         child: Text(
                            //     //           'Sending project file',
                            //     //           style: TextStyle(
                            //     //               color: CustomColors.TextHeader,
                            //     //               fontWeight: FontWeight.w600),
                            //     //         ),
                            //     //       ),
                            //     //       Image.asset('assets/images/bell-small.png'),
                            //     //     ],
                            //     //   ),
                            //     //   decoration: BoxDecoration(
                            //     //     gradient: LinearGradient(
                            //     //       stops: [0.015, 0.015],
                            //     //       colors: [CustomColors.GreenIcon, Colors.white],
                            //     //     ),
                            //     //     borderRadius: BorderRadius.all(
                            //     //       Radius.circular(5.0),
                            //     //     ),
                            //     //     boxShadow: [
                            //     //       BoxShadow(
                            //     //         color: CustomColors.GreyBorder,
                            //     //         blurRadius: 10.0,
                            //     //         spreadRadius: 5.0,
                            //     //         offset: Offset(0.0, 0.0),
                            //     //       ),
                            //     //     ],
                            //     //   ),
                            //     // ),
                            //     // Container(
                            //     //   margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
                            //     //   padding: EdgeInsets.fromLTRB(5, 13, 5, 13),
                            //     //   child: Row(
                            //     //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //     //     children: <Widget>[
                            //     //       Image.asset('assets/images/checked-empty.png'),
                            //     //       Text(
                            //     //         '10.00 AM',
                            //     //         style:
                            //     //             TextStyle(color: CustomColors.TextGrey),
                            //     //       ),
                            //     //       Container(
                            //     //         width: 180,
                            //     //         child: Text(
                            //     //           'Meeting with client',
                            //     //           style: TextStyle(
                            //     //               color: CustomColors.TextHeader,
                            //     //               fontWeight: FontWeight.w600),
                            //     //         ),
                            //     //       ),
                            //     //       Image.asset(
                            //     //           'assets/images/bell-small-yellow.png'),
                            //     //     ],
                            //     //   ),
                            //     //   decoration: BoxDecoration(
                            //     //     gradient: LinearGradient(
                            //     //       stops: [0.015, 0.015],
                            //     //       colors: [CustomColors.PurpleIcon, Colors.white],
                            //     //     ),
                            //     //     borderRadius: BorderRadius.all(
                            //     //       Radius.circular(5.0),
                            //     //     ),
                            //     //     boxShadow: [
                            //     //       BoxShadow(
                            //     //         color: CustomColors.GreyBorder,
                            //     //         blurRadius: 10.0,
                            //     //         spreadRadius: 5.0,
                            //     //         offset: Offset(0.0, 0.0),
                            //     //       ),
                            //     //     ],
                            //     //   ),
                            //     // ),
                            //     // Container(
                            //     //   margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
                            //     //   padding: EdgeInsets.fromLTRB(5, 13, 5, 13),
                            //     //   child: Row(
                            //     //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //     //     children: <Widget>[
                            //     //       Image.asset('assets/images/checked-empty.png'),
                            //     //       Text(
                            //     //         '13.00 PM',
                            //     //         style:
                            //     //             TextStyle(color: CustomColors.TextGrey),
                            //     //       ),
                            //     //       Container(
                            //     //         width: 180,
                            //     //         child: Text(
                            //     //           'Email client',
                            //     //           style: TextStyle(
                            //     //               color: CustomColors.TextHeader,
                            //     //               fontWeight: FontWeight.w600),
                            //     //         ),
                            //     //       ),
                            //     //       Image.asset('assets/images/bell-small.png'),
                            //     //     ],
                            //     //   ),
                            //     //   decoration: BoxDecoration(
                            //     //     gradient: LinearGradient(
                            //     //       stops: [0.015, 0.015],
                            //     //       colors: [CustomColors.GreenIcon, Colors.white],
                            //     //     ),
                            //     //     borderRadius: BorderRadius.all(
                            //     //       Radius.circular(5.0),
                            //     //     ),
                            //     //     boxShadow: [
                            //     //       BoxShadow(
                            //     //         color: CustomColors.GreyBorder,
                            //     //         blurRadius: 10.0,
                            //     //         spreadRadius: 5.0,
                            //     //         offset: Offset(0.0, 0.0),
                            //     //       ),
                            //     //     ],
                            //     //   ),
                            //     // ),
                            //     // Container(
                            //     //   margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
                            //     //   padding: EdgeInsets.fromLTRB(5, 13, 5, 13),
                            //     //   child: Row(
                            //     //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //     //     children: <Widget>[
                            //     //       Image.asset('assets/images/checked-empty.png'),
                            //     //       Text(
                            //     //         '13.00 PM',
                            //     //         style:
                            //     //             TextStyle(color: CustomColors.TextGrey),
                            //     //       ),
                            //     //       Container(
                            //     //         width: 180,
                            //     //         child: Text(
                            //     //           'Meeting with client',
                            //     //           style: TextStyle(
                            //     //               color: CustomColors.TextHeader,
                            //     //               fontWeight: FontWeight.w600),
                            //     //         ),
                            //     //       ),
                            //     //       Image.asset(
                            //     //           'assets/images/bell-small-yellow.png'),
                            //     //     ],
                            //     //   ),
                            //     //   decoration: BoxDecoration(
                            //     //     gradient: LinearGradient(
                            //     //       stops: [0.015, 0.015],
                            //     //       colors: [CustomColors.PurpleIcon, Colors.white],
                            //     //     ),
                            //     //     borderRadius: BorderRadius.all(
                            //     //       Radius.circular(5.0),
                            //     //     ),
                            //     //     boxShadow: [
                            //     //       BoxShadow(
                            //     //         color: CustomColors.GreyBorder,
                            //     //         blurRadius: 10.0,
                            //     //         spreadRadius: 5.0,
                            //     //         offset: Offset(0.0, 0.0),
                            //     //       ),
                            //     //     ],
                            //     //   ),
                            //     // ),
                            //     // Container(
                            //     //   margin: EdgeInsets.fromLTRB(20, 0, 20, 15),
                            //     //   padding: EdgeInsets.fromLTRB(5, 13, 5, 13),
                            //     //   child: Row(
                            //     //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //     //     children: <Widget>[
                            //     //       Image.asset('assets/images/checked-empty.png'),
                            //     //       Text(
                            //     //         '13.00 PM',
                            //     //         style:
                            //     //             TextStyle(color: CustomColors.TextGrey),
                            //     //       ),
                            //     //       Container(
                            //     //         width: 180,
                            //     //         child: Text(
                            //     //           'Email client',
                            //     //           style: TextStyle(
                            //     //               color: CustomColors.TextHeader,
                            //     //               fontWeight: FontWeight.w600),
                            //     //         ),
                            //     //       ),
                            //     //       Image.asset('assets/images/bell-small.png'),
                            //     //     ],
                            //     //   ),
                            //     //   decoration: BoxDecoration(
                            //     //     gradient: LinearGradient(
                            //     //       stops: [0.015, 0.015],
                            //     //       colors: [CustomColors.GreenIcon, Colors.white],
                            //     //     ),
                            //     //     borderRadius: BorderRadius.all(
                            //     //       Radius.circular(5.0),
                            //     //     ),
                            //     //     boxShadow: [
                            //     //       BoxShadow(
                            //     //         color: CustomColors.GreyBorder,
                            //     //         blurRadius: 10.0,
                            //     //         spreadRadius: 5.0,
                            //     //         offset: Offset(0.0, 0.0),
                            //     //       ),
                            //     //     ],
                            //     //   ),
                            //     // ),
                            //     // SizedBox(height: 15)
                            //   ],
                            // ),
                            );
                  }
                },
              ),
            ],
          ),
        ));
  }
}
