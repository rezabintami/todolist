part of 'pages.dart';

class FriendListPage extends StatefulWidget {
  @override
  _FriendListPageState createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {
  TextEditingController searchController = TextEditingController();
  bool isSearchOn = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.bloc<FriendlistBloc>().add(ReturnFriendList());
        context.bloc<PageBloc>().add(GoToLandingPage());
        return;
      },
      child: Scaffold(
        appBar: friendAppbar(),
        body: Container(child: BlocBuilder<FriendlistBloc, FriendlistState>(
          builder: (context, state) {
            if (state is FriendlistInitial) {
              return Container(
                child: Center(child: Text("Loading..")),
              );
            } else {
              FriendListLoaded loaded = state as FriendListLoaded;
              if (loaded.friend.length == 0) {
                return Container(
                  child: Center(child: Text("You Dont have Friend to shared")),
                );
              } else {
                return ListView.builder(
                  itemCount: loaded.friend.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
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
                                    child:
                                        Image.asset('assets/images/photo.png'),
                                  ),
                                  Text(loaded.friend[index].name,
                                      style: TextStyle(fontSize: 15))
                                ],
                              ),
                            ),
                            // Container(
                            //   width: MediaQuery.of(context).size.width * 0.15,
                            //   child: Row(
                            //     children: [
                            //       Container(
                            //         width: 10,
                            //         height: 10,
                            //         decoration: BoxDecoration(
                            //             shape: BoxShape.circle,
                            //             color: Colors.greenAccent),
                            //       ),
                            //       SizedBox(width: 10),
                            //       Text("Online", style: TextStyle(fontSize: 10))
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }
          },
        )
            //  ListView(
            //   physics: NeverScrollableScrollPhysics(),
            //   children: [
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Text("Friend List", style: TextStyle(fontSize: 15)),
            //         ),
            //         Container(
            //           height: MediaQuery.of(context).size.height,
            //           child: ListView(
            //             children: [
            //               InkWell(
            //                 onTap: () {},
            //                 child: Container(
            //                   padding: EdgeInsets.symmetric(
            //                       horizontal: 20.0, vertical: 10.0),
            //                   child: Row(
            //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       Container(
            //                         width:
            //                             MediaQuery.of(context).size.width * 0.6,
            //                         child: Row(
            //                           mainAxisAlignment: MainAxisAlignment.start,
            //                           children: [
            //                             Container(
            //                               margin:
            //                                   EdgeInsets.fromLTRB(0, 0, 20, 0),
            //                               child: Image.asset(
            //                                   'assets/images/photo.png'),
            //                             ),
            //                             Text("Rizaldi",
            //                                 style: TextStyle(fontSize: 15))
            //                           ],
            //                         ),
            //                       ),
            //                       Container(
            //                         width:
            //                             MediaQuery.of(context).size.width * 0.15,
            //                         child: Row(
            //                           children: [
            //                             Container(
            //                               width: 10,
            //                               height: 10,
            //                               decoration: BoxDecoration(
            //                                   shape: BoxShape.circle,
            //                                   color: Colors.greenAccent),
            //                             ),
            //                             SizedBox(width: 10),
            //                             Text("Online",
            //                                 style: TextStyle(fontSize: 10))
            //                           ],
            //                         ),
            //                       )
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //               InkWell(
            //                 onTap: () {},
            //                 child: Container(
            //                   padding: EdgeInsets.symmetric(
            //                       horizontal: 20.0, vertical: 10.0),
            //                   child: Row(
            //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                     children: [
            //                       Container(
            //                         width:
            //                             MediaQuery.of(context).size.width * 0.6,
            //                         child: Row(
            //                           mainAxisAlignment: MainAxisAlignment.start,
            //                           children: [
            //                             Container(
            //                               margin:
            //                                   EdgeInsets.fromLTRB(0, 0, 20, 0),
            //                               child: Image.asset(
            //                                   'assets/images/photo.png'),
            //                             ),
            //                             Text("Dimas",
            //                                 style: TextStyle(fontSize: 15))
            //                           ],
            //                         ),
            //                       ),
            //                       Container(
            //                         width:
            //                             MediaQuery.of(context).size.width * 0.15,
            //                         child: Row(
            //                           children: [
            //                             Container(
            //                               width: 10,
            //                               height: 10,
            //                               decoration: BoxDecoration(
            //                                   shape: BoxShape.circle,
            //                                   color: Colors.greenAccent),
            //                             ),
            //                             SizedBox(width: 10),
            //                             Text("Online",
            //                                 style: TextStyle(fontSize: 10))
            //                           ],
            //                         ),
            //                       )
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            ),
      ),
    );
  }

  Widget friendAppbar() {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: ListTile(
                    leading: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          if (isSearchOn) {
                            context
                                .bloc<FriendlistBloc>()
                                .add(ReturnFriendList());
                            context
                                .bloc<FriendBloc>()
                                .add(GetFriend(searchController.text));
                            context
                                .bloc<PageBloc>()
                                .add(GoToAddFriendPage(searchController.text));
                          }
                        }),
                    title: TextField(
                      onChanged: (text) {
                        setState(() {
                          isSearchOn = text.length >= 1;
                        });
                      },
                      controller: searchController,
                      decoration: InputDecoration(
                          hintText: "Search", border: InputBorder.none),
                    ),
                    trailing: isSearchOn
                        ? IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: () {
                              setState(() {
                                isSearchOn = false;
                              });
                              searchController.clear();
                            })
                        : null),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white, size: 30),
            padding: EdgeInsets.only(right: 20),
            onPressed: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              await AuthServices.signOut();
              context.bloc<UserBloc>().add(SignOut());
              preferences.clear();

              // context.bloc<PageBloc>().add(GoToLoginPage());
            },
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
