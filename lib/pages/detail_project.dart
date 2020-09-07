part of 'pages.dart';

class DetailProjectPage extends StatefulWidget {
  final UpdateTask updatetask;
  DetailProjectPage(this.updatetask);
  @override
  _DetailProjectPageState createState() => _DetailProjectPageState();
}

class _DetailProjectPageState extends State<DetailProjectPage> {
  UpdateTask addTask;
  TextEditingController nameController = TextEditingController();
  String tanggal = "";
  String dates = "";
  String waktu = "";
  List<String> groups = [
    "Personal",
    "Work",
    "Meeting",
    "Study",
    "Shopping",
    "Party"
  ];
  getdata() async {
    nameController = TextEditingController(text: widget.updatetask.name);
    tanggal = widget.updatetask.date + " " + widget.updatetask.time;
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    addTask = UpdateTask();
    addTask.group = "Personal";

    return WillPopScope(
      onWillPop: () async {
        context.bloc<ProjectBloc>().add(ReturnProject());
        context.bloc<TaskBloc>().add(GetAllTask());
        context.bloc<PageBloc>().add(GoToLandingPage());
        return;
      },
      child: Scaffold(
          appBar: projectAppbar(context),
          body: Container(
            padding: EdgeInsets.all(15),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text(
                      'Update task',
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: TextFormField(
                        autofocus: true,
                        controller: nameController,
                        style: TextStyle(
                            fontSize: 22, fontStyle: FontStyle.normal),
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            width: 1.0,
                            color: CustomColors.GreyBorder,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Text(
                        'Choose date',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        DateTime date = DateTime(1900);

                        date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100));
                        if (date != null) {
                          TimeOfDay time;
                          time = TimeOfDay.now();
                          TimeOfDay t = await showTimePicker(
                              context: context, initialTime: time);
                          if (t != null)
                            setState(() {
                              time = t;
                            });
                          tanggal = DateFormat("yyyy-MM-dd").format(date);
                          dates = tanggal;
                          waktu = "${time.hour}:${time.minute}";
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Row(
                          children: <Widget>[
                            Text(
                              (tanggal == "") ? "Date Time" : tanggal,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(width: 5),
                            RotatedBox(
                              quarterTurns: 1,
                              child: Icon(Icons.chevron_right),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 25),
                    RaisedButton(
                      onPressed: () async {
                        addTask.name = nameController.text;
                        addTask.group = widget.updatetask.group;
                        if (dates == "") {
                          addTask.date = widget.updatetask.date;
                        } else {
                          addTask.date = dates;
                        }
                        if (waktu == "") {
                          addTask.time = widget.updatetask.time;
                        } else {
                          addTask.time = waktu;
                        }
                        addTask.id = widget.updatetask.id;
                        nameController.clear();
                        tanggal = "";
                        await TaskServices.updateTask(addTask);
                        context.bloc<ProjectBloc>().add(ReturnProject());
                        context.bloc<TaskBloc>().add(ReturnAllTask());
                        context.bloc<TaskBloc>().add(GetAllTask());
                        context.bloc<PageBloc>().add(GoToLandingPage());
                      },
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        // width: MediaQuery.of(context).size.width / 1.2,
                        height: 60,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              CustomColors.BlueLight,
                              CustomColors.BlueDark,
                            ],
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: CustomColors.BlueShadow,
                              blurRadius: 2.0,
                              spreadRadius: 1.0,
                              offset: Offset(0.0, 0.0),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Center(
                          child: const Text(
                            'Update task',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget projectAppbar(BuildContext context) {
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
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Today you have no tasks',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
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
}
