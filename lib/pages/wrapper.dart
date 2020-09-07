part of 'pages.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  String splashscreen;
  getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      splashscreen = prefs.getString('splash_screen');
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseUser firebaseUser = Provider.of<FirebaseUser>(context);

    if (firebaseUser == null) {
      if (splashscreen != null) {
        if (!(prevPageEvent is GoToLoginPage)) {
          prevPageEvent = GoToLoginPage();
          context.bloc<PageBloc>().add(prevPageEvent);
        }
      } else {
        prevPageEvent = GoToOnBoardingPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    } else {
      if (!(prevPageEvent is GoToLandingPage)) {
        print(firebaseUser.uid);
        context.bloc<UserBloc>().add(LoadUser(firebaseUser.uid));
        context.bloc<TaskBloc>().add(GetAllTask());
        prevPageEvent = GoToLandingPage();
        context.bloc<PageBloc>().add(prevPageEvent);
      }
    }

    return BlocBuilder<PageBloc, PageState>(
      builder: (context, state) => (state is OnLoginPage)
          ? LoginPage()
          : (state is OnLandingPage)
              ? LandingPage()
              : (state is OnOnBoardingPage)
                  ? Onboarding()
                  : (state is OnProjectPage)
                      ? ProjectPage()
                      : (state is OnProjectDetailPage)
                          ? DetailProjectPage(state.updatetask)
                          : (state is OnFriendListPage)
                              ? FriendListPage()
                              : (state is OnAddFriendPage)
                                  ? AddFriendPage(state.name)
                                  : Container(),
    );
  }
}
