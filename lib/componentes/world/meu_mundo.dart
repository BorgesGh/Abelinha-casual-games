import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:primeiro_jogo/Jogo.dart';
import 'package:primeiro_jogo/componentes/Enemy.dart';
import 'package:primeiro_jogo/componentes/Player.dart';
import 'package:primeiro_jogo/componentes/world/background_parallax.dart';

class MeuMundo extends World with HasGameRef<Jogo>, HasCollisionDetection {
  late final background;
  late TextComponent pontuacaoText;
  late SpawnComponent _spawnComponent;

  double width = 0;
  double height = 0;

  @override
  Future<void> onLoad() async {
    debugMode = true;

    width = gameRef.size.x;
    height = gameRef.size.y;

    // Exibir pontuação no canto superior esquerdo
    pontuacaoText = TextComponent(
        position: Vector2((-width / 2) + 40, (-height / 2) + 60),
        text: gameRef.pontuacao.toString(),
        anchor: Anchor.center,
        priority: 10,
        scale: Vector2(4, 4));

    add(pontuacaoText);

    background = BackgroundParallax();

    add(background);

    _spawnComponent = SpawnComponent(
      // Spawn dos inimigos na direita da tela
      factory: (index) {
        return Enemy();
      },
      period: 1,
      area:
          Rectangle.fromLTWH((width / 2) + 50, -(height / 2), 20, height - 70),
      autoStart: false,
    );

    add(_spawnComponent);
    return super.onLoad();
  }

  void startSpawnInimigos() {
    _spawnComponent.timer.start();
  }

  void stopSpawnInimigos() {
    _spawnComponent.timer.stop();
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
