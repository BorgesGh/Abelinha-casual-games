import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/cupertino.dart';
import 'package:primeiro_jogo/sprites/Enemy.dart';
import 'package:primeiro_jogo/sprites/Player.dart';
import 'package:flame_audio/flame_audio.dart';

import 'Assets.dart';

class Jogo extends FlameGame with PanDetector, HasCollisionDetection{

  late Player jogador;


  @override
  Future<void> onLoad() async{

    //Crregamento. tempo

    FlameAudio.play("MainTitle.mp3");

    await Future.delayed(const Duration(seconds: 2));

    //Carregar tudo que há no jogo
    final background = await loadParallaxComponent(
        [
          ParallaxImageData(Assets.background),
        ],
      baseVelocity: Vector2(2, 0),
      repeat: ImageRepeat.repeatX,

      velocityMultiplierDelta: Vector2(6, 0),
      size: Vector2(1200, 1000)
    );

    add(background);

    jogador = Player();

    add(jogador);


    add(SpawnComponent(
      factory: (index){
        return Enemy();
      },
      period: 3,
      area: Rectangle.fromLTWH(size.x + 50, 40, 20, size.y - 40),

    ));

  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  //Comportamentos que o usuário pode fazer

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
}