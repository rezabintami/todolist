part of 'pages.dart';

class AddFriendPage extends StatefulWidget {
  final String searchname;
  AddFriendPage(this.searchname);
  @override
  _AddFriendPageState createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  TextEditingController searchController = TextEditingController();
  bool isSearchOn = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        context
            .bloc<FriendlistBloc>()
            .add(GetFriendList(preferences.getString("account_id")));
        context.bloc<FriendBloc>().add(ReturnFriend());
        context.bloc<PageBloc>().add(GoToFriendListPage());
        return;
      },
      child: Scaffold(
        appBar: addfriendAppbar(),
        body: Container(child: BlocBuilder<FriendBloc, FriendState>(
          builder: (context, state) {
            if (state is FriendInitial) {
              return Container(
                child: Center(child: Text("Loading..")),
              );
            } else {
              FriendLoaded loaded = state as FriendLoaded;
              if (loaded.friend.length == 0) {
                return Container(
                  child: Center(
                      child: Text("'" + widget.searchname + "' cannot found.")),
                );
              } else {
                return ListView.builder(
                  itemCount: loaded.friend.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Row(
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
                                Text(loaded.friend[index].name,
                                    style: TextStyle(fontSize: 15))
                              ],
                            ),
                          ),
                          IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () async {
                                FriendList friend = FriendList();
                                friend.email = loaded.friend[index].email;
                                friend.id = loaded.friend[index].id;
                                friend.status = loaded.friend[index].status;
                                friend.name = loaded.friend[index].name;
                                await FriendServices.addFriend(friend);
                              })
                        ],
                      ),
                    );
                  },
                );
              }
            }
          },
        )
            //  ListView(
            //   children: [
            //     Container(
            //       padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Container(
            //             width: MediaQuery.of(context).size.width * 0.6,
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               children: [
            //                 Container(
            //                   margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
            //                   child: Image.asset('assets/images/photo.png'),
            //                 ),
            //                 Text("Anggara", style: TextStyle(fontSize: 15))
            //               ],
            //             ),
            //           ),
            //           IconButton(icon: Icon(Icons.add), onPressed: () {})
            //         ],
            //       ),
            //     ),
            //     Container(
            //       padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Container(
            //             width: MediaQuery.of(context).size.width * 0.6,
            //             child: Row(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               children: [
            //                 Container(
            //                   margin: EdgeInsets.fromLTRB(0, 0, 20, 0),
            //                   child: Image.asset('assets/images/photo.png'),
            //                 ),
            //                 Text("Dimas", style: TextStyle(fontSize: 15))
            //               ],
            //             ),
            //           ),
            //           IconButton(icon: Icon(Icons.add), onPressed: () {})
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            ),
      ),
    );
  }

  Widget addfriendAppbar() {
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
        title: Container(
          margin: EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "'" + widget.searchname + "'",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
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
