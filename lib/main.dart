import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:primeiro_jogo/Jogo.dart';
import 'package:primeiro_jogo/screens/pages/main_menu_screen.dart';
import 'package:primeiro_jogo/screens/overlays/game_over_overlay.dart';

import 'screens/pages/loading_page.dart';

void main() {
  runApp(MyGameApp());
}

class MyGameApp extends StatefulWidget {
  @override
  _MyGameAppState createState() => _MyGameAppState();
}

class _MyGameAppState extends State<MyGameApp> {
  bool isGameStarted = false;

  late final Jogo jogo;

  @override
  void initState() {
    super.initState();
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
              game: jogo =
                  Jogo(larguraDaTela: MediaQuery.of(context).size.width),
              loadingBuilder: (context) => LoadingPage(),
              overlayBuilderMap: {
                GameState.gameOver.name: (context, game) => GameOverOverlay(
                      game: jogo,
                      title: " FIM DE JOGO! ",
                      subtitle: "Sua pontuação foi de: ${jogo.pontuacao.value}",
                    )
              },
            ) // Se o jogo começou, exibe o GameWidget
          : MainMenuPage(
              onStartGame: startGame), // Caso contrário, exibe o menu principal
    );
  }
}
