import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:primeiro_jogo/Jogo.dart';
import 'package:primeiro_jogo/sprites/Enemy.dart';
import 'package:primeiro_jogo/sprites/Player.dart';

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

    // Carregar tudo que há no jogo
    // background = Parallax(
    //   [
    //     ParallaxLayer(
    //       ParallaxRenderer()
    //       Constants.background
    //       ),
    //   ],
    //   baseVelocity: Vector2(2, 0),
    //   repeat: ImageRepeat.repeatX,
    //   velocityMultiplierDelta: Vector2(6, 0),
    //   size: Vector2(1200, 1000),
    // );

    // add(background);

    _spawnComponent = SpawnComponent(
      // Spawn dos inimigos na direita da tela
      factory: (index) {
        return Enemy();
      },
      period: 1,
      area: Rectangle.fromLTWH(width / 2, -(height / 2), 20, height - 70),
      autoStart: false,
    );

    add(_spawnComponent);
    return super.onLoad();
  }

  void startSpawnInimigos() {
    print('Inimigos começaram a aparecer');
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
