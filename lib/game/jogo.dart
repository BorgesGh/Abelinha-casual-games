import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/cupertino.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:primeiro_jogo/game/componentes/Player.dart';
import 'package:primeiro_jogo/game/componentes/world/meu_mundo.dart';

import '../utils/constants.dart';

enum GameState { intro, playing, gameOver }

class Jogo extends FlameGame with PanDetector {
  double? larguraDaTela;
  Jogo({required this.larguraDaTela})
      : super(
          world: MeuMundo(),
        );

  late Player jogador;

  ValueNotifier<int> pontuacao = ValueNotifier(0);

  GameState state = GameState.intro;

  @override
  Future<void> onLoad() async {
    world.add(jogador = Player());
    intro();

    // Carregamento. tempo
    FlameAudio.bgm.play("MainTitle.mp3");

    await Future.delayed(const Duration(seconds: 1));
  }

  void intro() {
    state = GameState.intro;
    //Add intro component no World
  }

  void gameOver() {
    state = GameState.gameOver;
    FlameAudio.bgm.stop(); // Parar música
    FlameAudio.play('derrotaMusic.mp3'); // Tocar som de Game Over

    (world as MeuMundo).stopSpawnInimigos();
    jogador.gameOver();
    overlays.add(GameState.gameOver.name);
  }

  void restart() {
    // print("Restartou!");
    state = GameState.playing;
    (world as MeuMundo).reset();
    pontuacao.value = 0;
    FlameAudio.bgm.play("MainTitle.mp3");

    overlays.remove(GameState.gameOver.name);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  // Comportamentos que o usuário pode fazer
  @override
  void onPanUpdate(DragUpdateInfo info) {
    // print(state);
    if (state != GameState.gameOver) {
      jogador.move(info.delta.global);
    }
  }

  @override
  void onPanStart(DragStartInfo info) {
    if (GameState.intro == state) {
      (world as MeuMundo).startSpawnInimigos();
      state = GameState.playing;
    }
    jogador.startPolen();
  }

  @override
  void onPanEnd(DragEndInfo info) {
    jogador.stopPolen();
  }
}
