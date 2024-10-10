import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/cupertino.dart';
import 'package:primeiro_jogo/sprites/Enemy.dart';
import 'package:primeiro_jogo/sprites/Player.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';

import 'Assets.dart';

enum GameState { intro, playing, gameOver }

class Jogo extends FlameGame with PanDetector, HasCollisionDetection {

  BuildContext context;

  Jogo({required this.context});

  late Player jogador;
  late TextComponent pontuacaoText;
  ValueNotifier<int> pontuacao = ValueNotifier(0);

  double? larguraDaTela;


  late SpawnComponent spawnInimigos;
  late final backgroundGame;
  GameState state = GameState.intro;

  bool get isGameOver => state == GameState.gameOver;

  @override
  Future<void> onLoad() async {
    larguraDaTela = MediaQuery.of(context).size.width;

    // Carregamento. tempo
    FlameAudio.bgm.play("MainTitle.mp3");

    await Future.delayed(const Duration(seconds: 2));

    // Exibir pontuação no canto superior esquerdo
    pontuacaoText = TextComponent(
      position: Vector2(20, 40),
      text: pontuacao.toString(),
      anchor: Anchor.topLeft,
      priority: 10,
      scale: Vector2(5, 5)

    );

    add(pontuacaoText);

    // Carregar tudo que há no jogo
    backgroundGame = await loadParallaxComponent(
      [
        ParallaxImageData(Assets.background),
      ],
      baseVelocity: Vector2(2, 0),
      repeat: ImageRepeat.repeatX,
      velocityMultiplierDelta: Vector2(6, 0),
      size: Vector2(1200, 1000),
    );

    add(backgroundGame);

    jogador = Player();
    add(jogador);

    spawnInimigos = SpawnComponent( // Spawn dos inimigos na direita da tela
      factory: (index) {
        return Enemy();
      },
      period: 3,
      area: Rectangle.fromLTWH(size.x + 50, 40, 20, size.y - 40),
    );

    add(spawnInimigos);

    // debugMode = true;
  }

  @override
  void update(double dt) {
    super.update(dt);

    pontuacaoText.text = '${pontuacao.value}';
  }

  // Comportamentos que o usuário pode fazer
  @override
  void onPanUpdate(DragUpdateInfo info) {
    jogador.move(info.delta.global);

  }

  @override
  void onPanStart(DragStartInfo info) {
    jogador.startPolen();

  }

  @override
  void onPanEnd(DragEndInfo info) {
    jogador.stopPolen();

  }

  void gameOver() {
    state = GameState.gameOver;
    FlameAudio.bgm.stop(); // Parar música
    FlameAudio.play('derrotaMusic.mp3'); // Tocar som de Game Over

    jogador.removeFromParent();
    spawnInimigos.timer.stop();
    overlays.add(GameState.gameOver.name);

  }

  void restart() {
    // print("Restartou!");
    state = GameState.playing;
    jogador.reset();
    pontuacao.value = 0;
    FlameAudio.bgm.play("MainTitle.mp3");

    jogador.addToParent(this);
    spawnInimigos.timer.start();

    overlays.remove(GameState.gameOver.name);

  }
}