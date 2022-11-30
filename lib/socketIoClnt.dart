import 'package:blue_jeans/touchGame.dart';
import 'package:flutter/material.dart';
import 'package:blue_jeans/jsonClass.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'balanceGame.dart';
// import 'package:blue_jeans/waitingRoom.dart';

String JOIN_TITLE = 'join';
String CREATE_TITLE = 'create';
String DISCONNECT_TITLE = 'disconnect';
String START_TITLE = 'start';
String RESULT_TITLE = 'result';

class ClientSocket with ChangeNotifier {
  ClientSocket(this.context) {
    connect();
  }

  BuildContext context;
  late Socket clntSocket;
  late List<dynamic> userList = [''];

  late List options = [''];

  late List<dynamic> losers = [''];
  late String loserStr = '';
  late String penalty = '';
  late var score;

  List<dynamic> getUserList() {
    return userList;
  }

  //소켓 연결
  void connect() {
    print('ClientSocket created. Connect to server...');
    //연결
    clntSocket = io('ws://211.57.200.6:3000', <String, dynamic>{
      'transports': ['websocket'],
      'forceNew': 'false',
    });
    // print("clntSocket : ${clntSocket.hashCode}");
  }

  //소켓 연결 해제
  void disconnect() {
    // clntSocket.disconnect();
    clntSocket.dispose();

    print('disconnected');
    super.dispose();
  }

  //방 참가시 동작 - 방 접속 요청 전송, 방에 접속한 유저 리스트 갱신받음
  void joiningRoomReq(User json) {
    print('Join to the room');
    print('room ID : ${json.roomId}');

    //emit에는 전송할 내용들 포함됨. 첫번째 param은 받는 타입(동작), 두번째 param은 데이터
    //방 참가 요청
    clntSocket.emit(JOIN_TITLE, json);

    //방 참가 응답 및 유저 리스트 갱신
    clntSocket.on(JOIN_TITLE, (response) {
      if (response['state'] == '200') {
        userList = response['users'];
        print('updated userList : $userList');
        notifyListeners();
      }
    });

    //게임 시작 응답
    clntSocket.on(START_TITLE, (response) {
      print('gameType = ${response['gameType']}');
      print('gameType = ${response['gameType'].runtimeType}');
      _gameResponseListener(response['gameType']);
      print('Game Started.');
    });
  }

  //방 생성 시 동작 - 방 생성 요청 전송, 방에 접속하는 유저 리스트 갱신받음
  void creatingRoomReq(User json) {
    print('create new the room');
    print('room ID : ${json.roomId}');

    //방 생성 요청
    clntSocket.emit(CREATE_TITLE, json);

    //방 생성 응답
    clntSocket.on(CREATE_TITLE, (response) {
      if (response['state'] == '200') {
        print("Room Created Successfully!");
        userList[0] = json.name;
        notifyListeners();
      }
    });

    //방 참가 응답 및 유저 리스트 갱신
    clntSocket.on(JOIN_TITLE, (response) {
      if (response['state'] == '200') {
        userList = response['users'];
        print('updated userList : $userList');
        notifyListeners();
      }
    });

    //게임 시작 응답
    clntSocket.on(START_TITLE, (response) {
      print('gameType = ${response['gameType']}');
      print('gameType = ${response['gameType'].runtimeType}');
      _gameResponseListener(response['gameType']);
      print('Game Started.');
    });
  }

  //방장이 서버로 보내는 게임 시작 요청
  void startGameReq(int selectedGame) {
    clntSocket.emit(START_TITLE, {'gameType': selectedGame});
  }

  //클라이언트에서의 게임 시작
  void _gameResponseListener(var gameType) {
    //터치 게임 시작
    if (gameType == 1 || gameType == '1') {
      print('go to the TouchGame');
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => TouchGame(socket: this)));
    }
    //폭탄 게임 시작
    else if (gameType == 2 || gameType == '2') {
      clntSocket.on('timeUp', (response) {
        print('Bomb Game Ended');
      });
      // Navigator.push(context, MaterialPageRoute(builder: (context) => BombGame()));

    }
    //밸런스 게임 시작
    else if (gameType == 3 || gameType == '3') {
      clntSocket.emit('options');
      clntSocket.on('options', (response) {
        //밸런스게임 선택지 받기
        print(response);
        options = response['option'];
      });
      print('go to the BalanceGame');
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => BalanceGame(socket: this)));
    }
  }

  //터치 게임 결과 전송 및 응답
  void touchGameResult(int myResult) {
    clntSocket.emit('touchGame', {'touchCount': myResult});

    clntSocket.on(RESULT_TITLE, (response) {
      print('losers : ${response['losers']}');
      print('penalty : ${response['penalty']}');
      print('score : ${response['score']}');
      loserStr = response['losers'];
      penalty = response['penalty'];
      score = response['score'];

      notifyListeners();
    });
  }

  void balanceGameResult(String myOption) {
    clntSocket.emit('balanceGame', {'option': myOption});

    clntSocket.on(RESULT_TITLE, (response) {
      print('losers : ${response['losers']}');
      print('penalty : ${response['penalty']}');
      print('score : ${response['score']}');
      losers = response['losers'];
      penalty = response['penalty'];
      score = response['score'];

      for (int i = 0; i < losers.length; i++) {
        loserStr += losers[i];
        if (i != losers.length - 1) {
          loserStr += ', ';
        }
      }
      print('loserStr : $loserStr');

      notifyListeners();
    });
  }
}
