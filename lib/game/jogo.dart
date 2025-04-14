import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:primeiro_jogo/game/componentes/Player.dart';
import 'package:primeiro_jogo/game/componentes/world/meu_mundo.dart';
import 'package:primeiro_jogo/utils/assets.dart';

enum GameState { intro, playing, gameOver }

class Jogo extends FlameGame<MeuMundo> with PanDetector {
  double? larguraDaTela;
  Jogo()
      : super(
          world: MeuMundo(),
        );

  late Player jogador;
  ValueNotifier<int> pontuacao = ValueNotifier(0);

  GameState state = GameState.intro;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    state = GameState.intro;
    pontuacao.value = 0;
    world.add(jogador = Player());

    FlameAudio.bgm.play(Assets.musicPlay); // Tocar música de introdução
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  void onGameResize(Vector2 size) {
    size = size;
    super.onGameResize(size);
  }

  void gameOver() {
    state = GameState.gameOver;

    FlameAudio.bgm.stop(); // Parar música
    FlameAudio.bgm.play(Assets.musicDefeat); // Tocar som de Game Over

    world.stopSpawnInimigos();
    jogador.gameOver();

    overlays.add(GameState
        .gameOver.name); // Adiciona o Overlay responsável pelo Game Over
  }

  void restart() {
    state = GameState.playing;

    FlameAudio.bgm.stop(); // Parar música de game over
    FlameAudio.bgm.play(Assets.musicPlay);

    world.reset();
    pontuacao.value = 0;

    overlays.remove(GameState.gameOver.name);
  }

  // Comportamentos que o usuário pode fazer
  @override
  void onPanUpdate(DragUpdateInfo info) {
    if (state != GameState.gameOver) {
      jogador.move(info.delta.global);
    }
  }

  @override
  void onPanStart(DragStartInfo info) {
    if (GameState.intro == state) {
      world.startSpawnInimigos();
      state = GameState.playing;
    }
    jogador.startPolen();
  }

  @override
  void onPanEnd(DragEndInfo info) {
    jogador.stopPolen();
  }
}
