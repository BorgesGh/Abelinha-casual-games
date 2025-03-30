import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:primeiro_jogo/game/jogo.dart';
import 'package:primeiro_jogo/screens/pages/main_menu_screen.dart';
import 'package:primeiro_jogo/screens/overlays/game_over_overlay.dart';
import 'package:primeiro_jogo/utils/assets.dart';

import 'screens/pages/loading_page.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // Garante que o Flutter esteja inicializado antes de executar o código
  FlameAudio.audioCache.loadAll([
    Assets.musicPlay,
    Assets.musicDefeat,
  ]);
  runApp(const MyGameApp());
}

class MyGameApp extends StatefulWidget {
  const MyGameApp({super.key});

  @override
  _MyGameAppState createState() => _MyGameAppState();
}

class _MyGameAppState extends State<MyGameApp> {
  bool isGameStarted = false;

  late final Jogo jogo;

  @override
  void initState() {
    super.initState();
    jogo = Jogo();
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
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: isGameStarted
          ? GameWidget(
              game: jogo,
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
