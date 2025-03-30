import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:primeiro_jogo/game/componentes/Enemy.dart';
import 'package:primeiro_jogo/game/componentes/world/background_parallax.dart';
import 'package:primeiro_jogo/game/jogo.dart';

class MeuMundo extends World with HasGameRef<Jogo>, HasCollisionDetection {
  late final background;
  late TextComponent pontuacaoText;
  late SpawnComponent _spawnEnemies;

  double width = 0;
  double height = 0;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    width = gameRef.size.x;
    height = gameRef.size.y;

    // Exibir pontuação no canto superior esquerdo
    pontuacaoText = TextComponent(
        position: Vector2((-width / 2) + 80, (-height / 2) + 100),
        text: gameRef.pontuacao.toString(),
        anchor: Anchor.center,
        priority: 10,
        scale: Vector2(4, 4));

    add(pontuacaoText);

    background = BackgroundParallax();

    add(background);

    _spawnEnemies = SpawnComponent(
      // Spawn dos inimigos na direita da tela
      factory: (index) {
        return Enemy();
      },
      period: 1,
      area: Rectangle.fromLTWH(
          (width / 2) + 50, -(height / 2), 20, height - height / 4),
      autoStart: false,
    );

    add(_spawnEnemies);
    return super.onLoad();
  }

  @override
  void onGameResize(Vector2 size) {
    // Atualiza a posição do texto de pontuação quando o tamanho do jogo muda
    pontuacaoText.position = Vector2((-size.x / 2) + 80, (-size.y / 2) + 100);
    pontuacaoText.scale = Vector2(4, 4);

    height = size.y;
    width = size.x;

    // Atualiza a área de spawn dos inimigos quando o tamanho do jogo muda
    _spawnEnemies.area = Rectangle.fromLTWH(
        (size.x / 2) + 50, -(size.y / 2), 20, size.y - size.y / 4);

    super.onGameResize(size);
  }

  void startSpawnInimigos() {
    _spawnEnemies.timer.start();
  }

  void stopSpawnInimigos() {
    _spawnEnemies.timer.stop();
    removeWhere((enemy) => enemy is Enemy); // Remove todos os inimigos do mundo
  }

  void reset() async {
    gameRef.jogador.reset();
    startSpawnInimigos();
  }

  @override
  void update(double dt) {
    pontuacaoText.text = '${gameRef.pontuacao.value}';
    super.update(dt);
  }
}
