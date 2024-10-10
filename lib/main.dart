import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:primeiro_jogo/Jogo.dart';
import 'package:primeiro_jogo/pages/MainMenuScreen.dart';
import 'package:primeiro_jogo/widgets/OverlayScreen.dart';

import 'pages/LoadScreen.dart';

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
  bool isGameStarted = false;

  late final Jogo gamely;

  @override
  void initState() {
    gamely = Jogo(context: context);
  } // Controla se o jogo começou


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
            game: gamely,
            loadingBuilder: (context) => LoadingScreen(),
            overlayBuilderMap: {
              GameState.gameOver.name: (context, game) =>
                OverlayScreen(
                  game: gamely,
                  title: " FIM DE JOGO! " ,
                  subtitle: "Sua pontuação foi de: ${gamely.pontuacao.value}",
                )
            },
          )  // Se o jogo começou, exibe o GameWidget
          : MainMenuScreen(onStartGame: startGame),  // Caso contrário, exibe o menu principal
    );
  }
}

