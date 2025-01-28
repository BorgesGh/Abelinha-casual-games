import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:primeiro_jogo/game/jogo.dart';

class BackgroundParallax extends ParallaxComponent<Jogo> with HasGameRef<Jogo> {
  BackgroundParallax()
      : super(position: Vector2.zero(), anchor: Anchor.center, priority: -1);

  @override
  FutureOr<void> onLoad() async {
    parallax = await gameRef.loadParallax(
      [
        ParallaxImageData('bg.png'),
      ],
      repeat: ImageRepeat.repeat,
      baseVelocity: Vector2(50, 0),
    );
    return super.onLoad();
  }
}
