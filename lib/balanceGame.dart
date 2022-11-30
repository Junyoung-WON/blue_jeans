import 'package:blue_jeans/resultScreen.dart';
import 'package:blue_jeans/socketIoClnt.dart';
import 'package:flutter/material.dart';
import 'package:blue_jeans/main.dart';

class BalanceGame extends StatefulWidget {
  final ClientSocket socket;

  const BalanceGame({super.key, required this.socket});

  @override
  State<BalanceGame> createState() => _BalanceGameState();
}

class _BalanceGameState extends State<BalanceGame> {
  List options = [''];
  String choice = '';

  @override
  void initState() {
    options = widget.socket.options;

    Future.delayed(Duration(seconds: 10), () {
      widget.socket.balanceGameResult(choice);
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(socket: widget.socket),
          ));
      print('result : $choice');
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    options = widget.socket.options;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray,
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            width: 390,
            height: 750,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/balanceGameScreen.png"),
                    fit: BoxFit.fill)),
          ),
          Positioned(
            top: 300,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 25, bottom: 40),
                  child: SizedBox(
                    width: 120,
                    height: 100,
                    child: Text(
                      options[0],
                      style: TextStyle(fontSize: 17, fontFamily: "Retro"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 150,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 80, bottom: 40),
                  child: SizedBox(
                    width: 120,
                    height: 100,
                    child: Text(
                      options[1],
                      style: TextStyle(fontSize: 17, fontFamily: "Retro"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 300,
            width: 390,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            gray,
                          ),
                          shape: MaterialStateProperty.resolveWith(((states) {
                            if (choice == options[0]) {
                              return BeveledRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(
                                    width: 1.5,
                                    color: blue,
                                    style: BorderStyle.solid),
                              );
                            }
                            return BeveledRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            );
                          }
                              // BeveledRectangleBorder(
                              //   borderRadius: BorderRadius.zero,
                              //   side: BorderSide(
                              //       width: 1.5,
                              //       color: Colors.black,
                              //       style: BorderStyle.solid),
                              // ),
                              ))),
                      onPressed: () {
                        setState(() {
                          choice = options[0];
                          print('현재 선택 : $choice');
                        });
                      },
                      child: Text(
                        '선택',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: 'Retro'),
                      )),
                ),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            gray,
                          ),
                          shape: MaterialStateProperty.resolveWith(((states) {
                            if (choice == options[1]) {
                              return BeveledRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side: BorderSide(
                                    width: 1.5,
                                    color: blue,
                                    style: BorderStyle.solid),
                              );
                            }
                            return BeveledRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            );
                          }))),
                      onPressed: () {
                        setState(() {
                          choice = options[1];
                          print('현재 선택 : $choice');
                        });
                      },
                      child: Text(
                        '선택',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontFamily: 'Retro'),
                      )),
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
