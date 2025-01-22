
import 'package:flame/components.dart';
import 'package:flutter/animation.dart';

import '../../Jogo.dart';

class ExplosionEffect extends SpriteAnimationComponent with HasGameRef<Jogo>{


  ExplosionEffect({required Vector2 position}) : super(
    position: position,
    removeOnFinish: true,
    anchor: Anchor.center,
    size: Vector2(80, 80),
  );
  
  @override
  Future<void> onLoad() async{

    final spriteFrames = [
      await game.loadSprite("assets/images/explosion/Explosion_1.png"),
      await game.loadSprite("assets/images/explosion/Explosion_2.png"),
      await game.loadSprite("assets/images/explosion/Explosion_3.png"),
      await game.loadSprite("assets/images/explosion/Explosion_4.png"),
      await game.loadSprite("assets/images/explosion/Explosion_5.png"),
      await game.loadSprite("assets/images/explosion/Explosion_6.png"),
      await game.loadSprite("assets/images/explosion/Explosion_7.png"),
      await game.loadSprite("assets/images/explosion/Explosion_8.png"),
      await game.loadSprite("assets/images/explosion/Explosion_9.png"),
      await game.loadSprite("assets/images/explosion/Explosion_10.png"),
    ];

    
    animation = SpriteAnimation.spriteList(spriteFrames, stepTime: 0.1); // Tempo que cada sprite vai durar
    
    
  }
  
  
}