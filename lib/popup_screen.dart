import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:blue_jeans/main.dart';
import 'package:blue_jeans/socketIoClnt.dart';
import 'package:blue_jeans/jsonClass.dart';
import 'package:blue_jeans/waitingRoom.dart';
import 'package:blue_jeans/resultScreen.dart';
import 'package:blue_jeans/touchGame.dart';

//ClientSocket socket = ClientSocket();

String randomRoomId() {
  var random = Random();
  dynamic val = List<int>.generate(6, (i) => random.nextInt(247));
  return base64UrlEncode(val);
}

void roomIdError(BuildContext context) {
  var dialog = Dialog(child: roomIdErrorScreen());
  showDialog(context: context, builder: (BuildContext context) => dialog);
}

void nicknameError(BuildContext context) {
  var dialog = Dialog(child: nicknameErrorScreen());
  showDialog(context: context, builder: (BuildContext context) => dialog);
}

void optionDialog(BuildContext context) {
  var dialog = Dialog(child: OptionScreen());
  showDialog(context: context, builder: (BuildContext context) => dialog);
}

void createRoomDialog(BuildContext context) {
  var dialog = Dialog(child: CreateRoomScreen());
  showDialog(context: context, builder: (BuildContext context) => dialog);
}

void joinRoomDialog(BuildContext context) {
  var dialog = Dialog(child: JoinRoomScreen());
  showDialog(context: context, builder: (BuildContext context) => dialog);
}

void showHelpDialog(BuildContext context) {
  var dialog = Dialog(child: ShowHelpScreen());
  showDialog(context: context, builder: (BuildContext context) => dialog);
}

class MyCheckBox extends StatefulWidget {
  MyCheckBox({super.key});

  @override
  State<MyCheckBox> createState() => _CheckBox();
}

class _CheckBox extends State<MyCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
          });
        });
  }
}

class ShowHelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/helpPage.png'), fit: BoxFit.fill),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 70, top: 50),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 90.0, right: 130, bottom: 20),
                child: Text(
                  "?????? ??????",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 80.0),
                child: Text(
                    "?????? ?????? ????????? ????????? ?????? ???????????? ????????? ??? ?????????, ???????????? ????????? ?????? ?????? ???????????? ????????? ??? ????????????.",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 80.0, top: 10),
                child: Text(
                    "??? ???????????? ????????? ????????? ???????????? ??? ????????? ???????????? ???????????? ????????? ??? ?????????, ??? ???????????? ????????? ????????? ???????????? ???????????? ???????????? ????????? ??? ????????????.",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class nicknameErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 300,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/error.png'), fit: BoxFit.fill)),
      child: Padding(
        padding: const EdgeInsets.only(left: 100.0, top: 50),
        child: Container(
          child: Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Text(
                "????????? ?????? ???????????????.",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              )),
        ),
      ),
    );
  }
}

class roomIdErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/error.png'), fit: BoxFit.fill)),
      child: Padding(
        padding: const EdgeInsets.only(left: 100.0, top: 50),
        child: Container(
          child: Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Text(
                "???????????? ????????????.",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              )),
        ),
      ),
    );
  }
}

class OptionScreen extends StatelessWidget {
  const OptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/option.png'), fit: BoxFit.fill)),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 130, left: 190),
          child: Column(
            children: [
              Row(
                children: [MyCheckBox(), MyCheckBox()],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  children: [MyCheckBox(), MyCheckBox()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({super.key});

  @override
  CreateRoomScreenState createState() => CreateRoomScreenState();
}

class CreateRoomScreenState extends State<CreateRoomScreen> {
  TextEditingController nicknameTEC = TextEditingController();
  String nickname = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/createRoom.png'), fit: BoxFit.fill),
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 300.0),
        child: Column(children: [
          RichText(
            text: TextSpan(text: ""),
          ),
          Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                maxLength: 6,
                style: TextStyle(
                  fontFamily: 'Retro',
                  fontSize: 20,
                ),
                controller: nicknameTEC,
                decoration: InputDecoration(
                    counterText: '',
                    hintText: '???????????? ???????????????.',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Colors.black45,
                          width: 3,
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.zero,
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 3,
                        ))),
              )),
          Flexible(
              child: InkWell(
                  child: Image.asset(
                    'assets/confirmButton.png',
                    width: 150,
                    height: 80,
                  ),
                  onTap: () {
                    nickname = nicknameTEC.text;
                    String roomId = randomRoomId();
                    // print(nickname);
                    // print(roomId);
                    var data = User(name: nickname, roomId: roomId);
                    ClientSocket socket = ClientSocket(context);
                    socket.creatingRoomReq(data);
                    // print("MainScreen\nsocket.hashCode : ${socket.hashCode}");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WaitingRoom(
                                  roomId: roomId,
                                  websocket: socket,
                                  isCaptain: true,
                                )));
                  }))
        ]),
      ),
    );
  }
}

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({super.key});

  @override
  JoinRoomScreenState createState() => JoinRoomScreenState();
}

class JoinRoomScreenState extends State<JoinRoomScreen> {
  TextEditingController roomIdTEC = TextEditingController();
  TextEditingController nicknameTEC = TextEditingController();
  String roomId = "";
  String nickname = "";

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/joinRoom.png'), fit: BoxFit.fill),
        ),
        child: Column(children: <Widget>[
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
            ),
          ),
          Flexible(flex: 0, child: Center()),
          Flexible(
            flex: 2,
            child: Container(
              constraints: BoxConstraints(minHeight: 200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextField(
                              maxLength: 6,
                              style: TextStyle(
                                fontFamily: 'Retro',
                                fontSize: 20,
                              ),
                              controller: nicknameTEC,
                              decoration: InputDecoration(
                                  hintText: '???????????? ???????????????.',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(
                                        color: Colors.black45,
                                        width: 3,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 3,
                                      ))),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: TextField(
                              maxLength: 8,
                              style: TextStyle(
                                fontFamily: 'Retro',
                                fontSize: 20,
                              ),
                              controller: roomIdTEC,
                              decoration: InputDecoration(
                                  counterText: '',
                                  hintText: '??? ????????? ???????????????.',
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(
                                        color: Colors.black45,
                                        width: 3,
                                      )),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.zero,
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 3,
                                      ))),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, bottom: 30),
            child: Flexible(
                child: InkWell(
                    child: Image.asset(
                      'assets/confirmButton.png',
                      width: 150,
                      height: 80,
                    ),
                    onTap: () {
                      nickname = nicknameTEC.text;
                      roomId = roomIdTEC.text;
                      // print(nickname);
                      // print(roomId);
                      var data = User(name: nickname, roomId: roomId);
                      ClientSocket socket = ClientSocket(context);
                      socket.joiningRoomReq(data);
                      // print("in MainScreen\nsocket.hashCode : ${socket.hashCode}");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WaitingRoom(
                                    roomId: roomId,
                                    websocket: socket,
                                    isCaptain: false,
                                  )));
                    })),
          )
        ]));
  }
}
