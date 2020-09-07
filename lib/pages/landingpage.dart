part of 'pages.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int bottomNavBarIndex = 0;
  int group = 0;
  AddTask addTask;
  TextEditingController nameController = TextEditingController();
  String tanggal = "";
  String waktu = "";
  List<String> groups = [
    "Personal",
    "Work",
    "Meeting",
    "Study",
    "Shopping",
    "Party"
  ];
  List<Widget> _container = [Home(), Task()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _container[bottomNavBarIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTask = AddTask();
          addTask.group = "Personal";

          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return ChangeNotifierProvider<Options>(
                create: (context) => Options(),
                child: Container(
                  height: MediaQuery.of(context).size.height - 80,
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: <Widget>[
                      Positioned(
                        top: MediaQuery.of(context).size.height / 25,
                        left: 0,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.elliptical(175, 30),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 2 - 340,
                        child: Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  child: Image.asset(
                                      'assets/images/fab-delete.png'),
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: <Color>[
                                        CustomColors.PurpleLight,
                                        CustomColors.PurpleDark,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: CustomColors.PurpleShadow,
                                        blurRadius: 10.0,
                                        spreadRadius: 5.0,
                                        offset: Offset(0.0, 0.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 10),
                                  Text(
                                    'Add new task',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    child: TextFormField(
                                      // initialValue: 'Book a table for dinner ',
                                      autofocus: true,
                                      controller: nameController,
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontStyle: FontStyle.normal),
                                      decoration: InputDecoration(
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    height: 60,
                                    padding: EdgeInsets.symmetric(vertical: 15),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                          width: 1.0,
                                          color: CustomColors.GreyBorder,
                                        ),
                                        bottom: BorderSide(
                                          width: 1.0,
                                          color: CustomColors.GreyBorder,
                                        ),
                                      ),
                                    ),
                                    child: Consumer<Options>(
                                      builder: (context, options, child) =>
                                          ListView(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () {
                                              options.quantity = 0;
                                              addTask.group = "Personal";
                                            },
                                            child: Center(
                                              child: (options.quantity == 0)
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          right: 10),
                                                      child: Text(
                                                        'Personal',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(5),
                                                        ),
                                                        color: CustomColors
                                                            .GreenIcon,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: CustomColors
                                                                .GreenShadow,
                                                            blurRadius: 5.0,
                                                            spreadRadius: 3.0,
                                                            offset: Offset(
                                                                0.0, 0.0),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Row(
                                                      children: <Widget>[
                                                        Container(
                                                          height: 10.0,
                                                          width: 10.0,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 4),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: CustomColors
                                                                .YellowAccent,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                          child:
                                                              Text('Personal'),
                                                        ),
                                                      ],
                                                    ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              options.quantity = 1;
                                              addTask.group = "Work";
                                            },
                                            child: Center(
                                              child: (options.quantity == 1)
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          right: 10),
                                                      child: Text(
                                                        'Work',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(5),
                                                        ),
                                                        color: CustomColors
                                                            .GreenIcon,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: CustomColors
                                                                .GreenShadow,
                                                            blurRadius: 5.0,
                                                            spreadRadius: 3.0,
                                                            offset: Offset(
                                                                0.0, 0.0),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Row(
                                                      children: <Widget>[
                                                        Container(
                                                          height: 10.0,
                                                          width: 10.0,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 4),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: CustomColors
                                                                .GreenIcon,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                          child: Text('Work'),
                                                        ),
                                                      ],
                                                    ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              options.quantity = 2;
                                              addTask.group = "Meeting";
                                            },
                                            child: Center(
                                              child: (options.quantity == 2)
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          right: 10),
                                                      child: Text(
                                                        'Meeting',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(5),
                                                        ),
                                                        color: CustomColors
                                                            .GreenIcon,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: CustomColors
                                                                .GreenShadow,
                                                            blurRadius: 5.0,
                                                            spreadRadius: 3.0,
                                                            offset: Offset(
                                                                0.0, 0.0),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Row(
                                                      children: <Widget>[
                                                        Container(
                                                          height: 10.0,
                                                          width: 10.0,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 4),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: CustomColors
                                                                .PurpleIcon,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                          child:
                                                              Text('Meeting'),
                                                        ),
                                                      ],
                                                    ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              options.quantity = 3;
                                              addTask.group = "Study";
                                            },
                                            child: Center(
                                              child: (options.quantity == 3)
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          right: 10),
                                                      child: Text(
                                                        'Study',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(5),
                                                        ),
                                                        color: CustomColors
                                                            .GreenIcon,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: CustomColors
                                                                .GreenShadow,
                                                            blurRadius: 5.0,
                                                            spreadRadius: 3.0,
                                                            offset: Offset(
                                                                0.0, 0.0),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Row(
                                                      children: <Widget>[
                                                        Container(
                                                          height: 10.0,
                                                          width: 10.0,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 4),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: CustomColors
                                                                .BlueIcon,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                          child: Text('Study'),
                                                        ),
                                                      ],
                                                    ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              options.quantity = 4;
                                              addTask.group = "Shopping";
                                            },
                                            child: Center(
                                              child: (options.quantity == 4)
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          right: 10),
                                                      child: Text(
                                                        'Shopping',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(5),
                                                        ),
                                                        color: CustomColors
                                                            .GreenIcon,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: CustomColors
                                                                .GreenShadow,
                                                            blurRadius: 5.0,
                                                            spreadRadius: 3.0,
                                                            offset: Offset(
                                                                0.0, 0.0),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Row(
                                                      children: <Widget>[
                                                        Container(
                                                          height: 10.0,
                                                          width: 10.0,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 4),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: CustomColors
                                                                .OrangeIcon,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                          child:
                                                              Text('Shopping'),
                                                        ),
                                                      ],
                                                    ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              options.quantity = 5;
                                              addTask.group = "Party";
                                            },
                                            child: Center(
                                              child: (options.quantity == 5)
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          right: 10),
                                                      child: Text(
                                                        'Party',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 5,
                                                              horizontal: 10),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(5),
                                                        ),
                                                        color: CustomColors
                                                            .GreenIcon,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: CustomColors
                                                                .GreenShadow,
                                                            blurRadius: 5.0,
                                                            spreadRadius: 3.0,
                                                            offset: Offset(
                                                                0.0, 0.0),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Row(
                                                      children: <Widget>[
                                                        Container(
                                                          height: 10.0,
                                                          width: 10.0,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 4),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: CustomColors
                                                                .BlueDark,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 10),
                                                          child: Text('Party'),
                                                        ),
                                                      ],
                                                    ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    child: Text(
                                      'Choose date',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  InkWell(
                                    onTap: () async {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
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
                                            context: context,
                                            initialTime: time);
                                        if (t != null)
                                          setState(() {
                                            time = t;
                                          });
                                        tanggal = DateFormat("yyyy-MM-dd")
                                            .format(date);
                                        String jam = "${time.hour}";
                                        String menit = "${time.minute}";
                                        if (jam.length == 1) {
                                          jam = "0${time.hour}";
                                        }
                                        if (menit.length == 1) {
                                          menit = "0${time.minute}";
                                        }
                                        waktu = "$jam:$menit";
                                        print(waktu);
                                      }
                                    },
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            (tanggal == "")
                                                ? "Date Time"
                                                : tanggal,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
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
                                  SizedBox(height: 20),
                                  RaisedButton(
                                    onPressed: () async {
                                      addTask.name = nameController.text;
                                      addTask.date = tanggal;
                                      addTask.time = waktu;
                                      nameController.clear();
                                      tanggal = "";
                                      await TaskServices.saveTask(addTask);
                                      Navigator.pop(context);
                                      print(addTask.name);
                                      print(addTask.group);
                                      print(addTask.date);
                                      context
                                          .bloc<TaskBloc>()
                                          .add(ReturnAllTask());
                                      context
                                          .bloc<TaskBloc>()
                                          .add(GetAllTask());
                                    },
                                    textColor: Colors.white,
                                    padding: const EdgeInsets.all(0.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.2,
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
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 10, 20, 10),
                                      child: Center(
                                        child: const Text(
                                          'Add task',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        elevation: 5,
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset('assets/images/fab-add.png'),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                CustomColors.PurpleLight,
                CustomColors.PurpleDark,
              ],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            ),
            boxShadow: [
              BoxShadow(
                color: CustomColors.PurpleShadow,
                blurRadius: 10.0,
                spreadRadius: 5.0,
                offset: Offset(0.0, 0.0),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavBarIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10,
        selectedLabelStyle: TextStyle(color: CustomColors.BlueDark),
        selectedItemColor: CustomColors.BlueDark,
        unselectedFontSize: 10,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Image.asset(
                'assets/images/home.png',
                color: (bottomNavBarIndex == 0)
                    ? CustomColors.BlueDark
                    : CustomColors.TextGrey,
              ),
            ),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Image.asset(
                'assets/images/task.png',
                color: (bottomNavBarIndex == 1)
                    ? CustomColors.BlueDark
                    : CustomColors.TextGrey,
              ),
            ),
            title: Text('Task'),
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            context.bloc<TaskBloc>().add(ReturnAllTask());
            context.bloc<TaskBloc>().add(GetAllTask());
          } else if (index == 1) {
            context.bloc<TaskBloc>().add(ReturnAllTask());
            context.bloc<TaskBloc>().add(GetAllTask());
          }
          setState(() {
            bottomNavBarIndex = index;
          });
        },
      ),
    );
  }
}
