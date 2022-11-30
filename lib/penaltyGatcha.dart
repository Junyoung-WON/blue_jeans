import 'package:blue_jeans/socketIoClnt.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:blue_jeans/main.dart';
import 'package:blue_jeans/gatchaScreen.dart';
import 'package:blue_jeans/penaltyScreen.dart';
import 'package:blue_jeans/resultScreen.dart';

class PenaltyGatcha extends StatelessWidget {
  final ClientSocket socket;
  var myImg = "assets/penalty.gif";

  PenaltyGatcha({super.key, required this.socket});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pop(context);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DrawResult(socket: socket),
          ));
    });
    return SizedBox(
        child: Lottie.asset('assets/penaltyGacha.json', repeat: false));
  }
}
