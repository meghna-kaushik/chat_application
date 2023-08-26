import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatapp/Buttonself.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController con;
  late Animation animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    animation =
        ColorTween(begin: Colors.blueGrey, end: Colors.grey).animate(con);
    con.forward();
    con.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: 60.0,
                    ),
                  ),
                ),
                AnimatedTextKit(animatedTexts: [
                  TypewriterAnimatedText(
                    'Flash Chat',
                    textStyle: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                    ),
                    speed: Duration(milliseconds: 200),
                  ),
                ]),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Logreg(Colors.lightBlueAccent, "Login", () {
              Navigator.pushNamed(context, '/login');
            }),
            Logreg(Colors.blueAccent, "Register", () {
              Navigator.pushNamed(context, "/register");
            }),
          ],
        ),
      ),
    );
  }
}
