
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:primeiro_jogo/Assets.dart';
import 'package:primeiro_jogo/sprites/Polen.dart';

import '../Jogo.dart';

class Player extends SpriteComponent with HasGameRef<Jogo>{

  static const double tamanho = 90.0;

  Player() : super(
    size: Vector2(tamanho,tamanho),
    anchor: Anchor.center
  );

  //Criador de polens
  late final SpawnComponent _polenSpawner;


  @override
  Future<void> onLoad() async{
    await super.onLoad();

    sprite = await gameRef.loadSprite(Assets.abelha);

    position = gameRef.size / 2;

    // declarando Como o Spawner de polen irá funcionar
    _polenSpawner = SpawnComponent(
      period: 1,
      selfPositioning: true,
      factory: (index) {
        return Polen(
          position: position + Vector2(20, 0)

        );
      },
      autoStart: false
    );

    game.add(_polenSpawner);

    add(RectangleHitbox(
      size: Vector2(tamanho - 25,tamanho - 30), // O tamanho da Hitbox tem que ser menor
      collisionType: CollisionType.passive, // O Tipo passivo indica que o objeto pode ser tocado por outro objeto.

      position: Vector2(width / 2 , height /2), // Centraliza o ponto de referência
      anchor: Anchor.center // Indica qual é o ponto de referência da HitBox, nesse caso o ponto de alinhamento é o centro.

    )
    );

  }

  void
  reset(){
    position = gameRef.size / 2;
  }

  void move(Vector2 pos){
    position.add(pos);
  }

  //Adicionamos agora os comportamentos de atirar

  void startPolen(){
    _polenSpawner.timer.start();
  }

  void stopPolen(){
    _polenSpawner.timer.stop();
  }
}