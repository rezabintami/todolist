part of 'pages.dart';

Widget fullAppbar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(210.0),
    child: GradientAppBar(
      flexibleSpace: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomPaint(
            painter: CircleOne(),
          ),
          CustomPaint(
            painter: CircleTwo(),
          ),
        ],
      ),
      title: Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserLoaded) {
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          state.user.name,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Today you have no tasks',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            context
                .bloc<FriendlistBloc>()
                .add(GetFriendList(preferences.getString("account_id")));
            context.bloc<PageBloc>().add(GoToFriendListPage());
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 20, 20, 0),
            child: Image.asset('assets/images/photo.png'),
          ),
        ),
      ],
      elevation: 0,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [CustomColors.HeaderBlueDark, CustomColors.HeaderBlueLight],
      ),
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: BlocBuilder<TaskBloc, TaskState>(
            builder: (context, state) {
              if (state is TaskInitial) {
                return Container();
              } else {
                TaskLoaded loaded = state as TaskLoaded;
                DateTime d1 = new DateTime.now();
                int now = d1.millisecondsSinceEpoch;
                int estimasi;
                List<GetTask> todaytask = new List();
                loaded.getTask.forEach((e) {
                  String tanggal = e.date + " " + e.time;
                  estimasi = DateTime.parse(tanggal).millisecondsSinceEpoch;
                  if (now < estimasi) {
                    todaytask.add(e);
                  }
                });
                int before;
                if (todaytask.length != 0) {
                  String datetime = todaytask[0].date + " " + todaytask[0].time;
                  DateTime d2 = DateTime.parse(datetime);
                  DateTime befores = DateTime(d2.year, d2.month, d2.day,
                      d2.hour - 1, d2.minute, d2.second);
                  before = befores.millisecondsSinceEpoch;
                } else {
                  todaytask.add(GetTask(name: "", time: ""));
                  before = 0;
                  now = 0;
                }
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                  decoration: BoxDecoration(
                    color: (now > before)
                        ? CustomColors.HeaderBlueDark
                        : CustomColors.HeaderGreyLight,
                    boxShadow: (now > before)
                        ? [
                            BoxShadow(
                              color: CustomColors.YellowBell,
                              blurRadius: 2.0,
                              spreadRadius: 1.0,
                              offset: Offset(0.0, 0.0),
                            )
                          ]
                        : null,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Today Reminder',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            todaytask[0].name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w300),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            todaytask[0].time,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.9,
                      ),
                      Image.asset(
                        'assets/images/bell-left.png',
                        scale: MediaQuery.of(context).textScaleFactor * 2,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 80),
                        child: Icon(
                          Icons.clear,
                          color: Colors.white,
                          size: 18.0,
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          )),
    ),
  );
}

Widget emptyAppbar(BuildContext context) {
  return PreferredSize(
    preferredSize: Size.fromHeight(75.0),
    child: GradientAppBar(
      flexibleSpace: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CustomPaint(
            painter: CircleOne(),
          ),
          CustomPaint(
            painter: CircleTwo(),
          ),
        ],
      ),
      title: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoaded) {
            return Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    state.user.name,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Today you have no tasks',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            context
                .bloc<FriendlistBloc>()
                .add(GetFriendList(preferences.getString("account_id")));
            context.bloc<PageBloc>().add(GoToFriendListPage());
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 20, 20, 0),
            child: Image.asset('assets/images/photo.png'),
          ),
        ),
      ],
      elevation: 0,
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [CustomColors.HeaderBlueDark, CustomColors.HeaderBlueLight],
      ),
    ),
  );
}

class CircleOne extends CustomPainter {
  Paint _paint;

  CircleOne() {
    _paint = Paint()
      ..color = CustomColors.HeaderCircle
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(28.0, 0.0), 99.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CircleTwo extends CustomPainter {
  Paint _paint;

  CircleTwo() {
    _paint = Paint()
      ..color = CustomColors.HeaderCircle
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(-30, 20), 50.0, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
