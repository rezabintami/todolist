part of 'pages.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: loginAppbar(),
      body: Container(
        child: Center(
            child: RaisedButton(
          onPressed: () async {
            await AuthServices.signIn();
            context.bloc<PageBloc>().add(GoToLandingPage());
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => LandingPage()),
            // );
          },
          textColor: Colors.white,
          padding: const EdgeInsets.all(0.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width / 1.4,
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
                  color: CustomColors.TextWhite,
                  blurRadius: 15.0,
                  spreadRadius: 7.0,
                  offset: Offset(0.0, 0.0),
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Center(
              child:
                  Text("Sign In With Google", style: TextStyle(fontSize: 20)),
            ),
          ),
        )),
      ),
    );
  }

  Widget loginAppbar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(100),
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
                'Login ToDoList',
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
