import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const JankenPage(),
    );
  }
}

class JankenPage extends StatefulWidget {
  const JankenPage({Key? key}) : super(key: key);

  @override
  State<JankenPage> createState() => _JankenPageState();
}

class _JankenPageState extends State<JankenPage> {

  List<String> matchResults = [];

// この関数はアラートダイアログに表示する勝負結果を作成します
  String createMatchResultString() {
    String matchResultString = '勝負数: $totalMatches 勝ち: $wins 負け: $losses 引き分け: $draws\n';
    for (int i = 0; i < matchResults.length; i++) {
      matchResultString += '${i+1}回目: ${matchResults[i]}\n';
    }
    return matchResultString;
  }
  void resetMatchResults() {
    matchResults.clear();
    totalMatches = 0;
    wins = 0;
    losses = 0;
    draws = 0;
    result = '引き分け';
  }

  String myHand = '✌️';

  String computerHand = '✌️';

  String result = '引き分け';

  int totalMatches = 0;
  int wins = 0;
  int losses = 0;
  int draws = 0;

  void selectHand(String selectedHand) {
    myHand = selectedHand;
    print(myHand);
    generativeComputerHand();
    judge();
    setState(() {});
  }

  void generativeComputerHand() {
    final randomNumber = Random().nextInt(3);
    computerHand = randomNumberToHand(randomNumber);
  }

  String randomNumberToHand(int randomNumber) {
    switch (randomNumber) {
      case 0:
        return '✊';
      case 1:
        return '✌️';
      case 2:
        return '🖐';
      default:
        return '✊';
    }
  }

  void judge() {
    totalMatches++;
    if (computerHand == myHand) {
      result = '引き分け';
      draws++;
    } else if (computerHand == '✊' && myHand == '🖐') {
      result = '勝ち';
      wins++;
    } else if (computerHand == '✌️' && myHand == '✊') {
      result = '勝ち';
      wins++;
    } else if (computerHand == '🖐' && myHand == '✌️') {
      result = '勝ち';
      wins++;
    } else {
      result = '負け';
      losses++;
    }
    matchResults.add(result); // 勝負結果をmatchResultsリストに追加する
    if (totalMatches == 5) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('5回目の勝負結果'),
            content: Text(
                '勝負数: $totalMatches 勝ち: $wins 負け: $losses 引き分け: $draws'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  resetMatchResults(); // アラートダイアログを閉じた後に、勝負結果を初期化する
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('じゃんけんするでー'),
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '勝負数: $totalMatches 勝ち: $wins 負け: $losses 引き分け: $draws',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            result,
            style: TextStyle(
              fontSize: 48,
            ),
          ),
          Text(
            computerHand,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            myHand,
            style: TextStyle(
              fontSize: 32,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  selectHand('✊');
                },
                child: Text('✊'),
              ),
              ElevatedButton(
                onPressed: () {
                  selectHand('✌️');
                },
                child: Text('✌️'),
              ),
              ElevatedButton(
                onPressed: () {
                  selectHand('🖐');
                },
                child: Text('🖐'),
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }
}



