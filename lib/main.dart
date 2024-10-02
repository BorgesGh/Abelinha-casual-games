import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:primeiro_jogo/Jogo.dart';
import 'package:primeiro_jogo/MainMenuScreen.dart';

import 'LoadScreen.dart';

void main() {
  runApp(
    MyGameApp()
  );
}

class MyGameApp extends StatefulWidget {
  @override
  _MyGameAppState createState() => _MyGameAppState();
}

class _MyGameAppState extends State<MyGameApp> {
  bool isGameStarted = false;  // Controla se o jogo começou

  void startGame() {
    setState(() {
      isGameStarted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isGameStarted
          ? GameWidget(
            game: Jogo(),
            loadingBuilder: (context) => LoadingScreen())  // Se o jogo começou, exibe o GameWidget
          : MainMenuScreen(onStartGame: startGame),  // Caso contrário, exibe o menu principal
    );
  }
}

