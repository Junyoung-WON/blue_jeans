import 'package:flutter/material.dart';
// import 'package:blue_jeans/gatchaScreen.dart';
import 'package:blue_jeans/loading.dart';
// import 'package:blue_jeans/penaltyScreen.dart';
import 'package:blue_jeans/popup_screen.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:blue_jeans/touchGame.dart';

const background = Color.fromARGB(255, 1, 125, 125);
const gray = Color.fromRGBO(192, 192, 192, 1);
const blue = Color.fromARGB(255, 42, 47, 209);

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingScreen(),
    ));

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray,
      body: SafeArea(
          child: Container(
        width: 400,
        height: 750,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/mainScreen.png"), fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      child: IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      showHelpDialog(context);
                    },
                  )),
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset('assets/helpIcon.png'))
                  // showhelp
                ],
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Flexible(
                flex: 5,
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(minWidth: 200),
                    child: Image.asset(
                      'assets/main_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                )),
            Spacer(flex: 2),
            Flexible(
              flex: 5,
              child: Container(
                constraints: BoxConstraints(minHeight: 200),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Image.asset(
                        "assets/joinButton.png",
                        width: 250,
                        height: 50,
                      ),
                      onTap: () => joinRoomDialog(context),
                    ),
                    InkWell(
                      child: Image.asset(
                        'assets/creatButton.png',
                        width: 250,
                        height: 50,
                      ),
                      onTap: (() => createRoomDialog(context)),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(flex: 2),
          ],
        ),
      )),
    );
  }
}
