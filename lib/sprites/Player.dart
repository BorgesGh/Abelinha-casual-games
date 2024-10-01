
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:primeiro_jogo/Assets.dart';
import 'package:primeiro_jogo/sprites/Polen.dart';

import '../Jogo.dart';

class Player extends SpriteComponent with HasGameRef<Jogo>{

  Player() : super(
    size: Vector2(90, 90),
    anchor: Anchor.centerLeft
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
      period: .2,
      selfPositioning: true,
      factory: (index) {
        return Polen(
          position: position + Vector2(20, 0)

        );

      },
      autoStart: false
    );

    game.add(_polenSpawner);

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