import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:primeiro_jogo/game/componentes/polen.dart';
import 'package:primeiro_jogo/game/jogo.dart';
import 'package:primeiro_jogo/utils/Constants.dart';

class Player extends SpriteComponent with HasGameRef<Jogo> {
  static const double tamanhodoPlayer = 90.0;

  Player()
      : super(
            size: Vector2(tamanhodoPlayer, tamanhodoPlayer),
            anchor: Anchor.center);
  late Vector2 _posicaoInicial;
  late final SpawnComponent _polenSpawner; //Criador de polens

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _posicaoInicial = Vector2(-(gameRef.size.x / 2) + 20, 0);

    sprite = await gameRef.loadSprite(Constants.abelha);

    position = _posicaoInicial;

    // declarando Como o Spawner de polen irá funcionar
    _polenSpawner = SpawnComponent(
        period: 1,
        selfPositioning: true,
        factory: (index) {
          return Polen(position: position + Vector2(20, 0));
        },
        autoStart: false);

    game.world.add(_polenSpawner);

    add(RectangleHitbox(
        size: Vector2(tamanhodoPlayer - 25,
            tamanhodoPlayer - 30), // O tamanho da Hitbox tem que ser menor
        collisionType: CollisionType
            .passive, // O Tipo passivo indica que o objeto pode ser tocado por outro objeto.

        position:
            Vector2(width / 2, height / 2), // Centraliza o ponto de referência
        anchor: Anchor
            .center // Indica qual é o ponto de referência da HitBox, nesse caso o ponto de alinhamento é o centro.

        ));
  }

  void reset() {
    position = _posicaoInicial;
    priority = 0;
  }

  void move(Vector2 pos) {
    position.add(pos);
  }

  //Adicionamos agora os comportamentos de atirar

  void startPolen() {
    _polenSpawner.timer.start();
  }

  void stopPolen() {
    _polenSpawner.timer.stop();
  }

  void gameOver() {
    _polenSpawner.timer.stop();
    removeWhere((component) => component is Polen);
  }
}
