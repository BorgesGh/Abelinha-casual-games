import 'package:flame/components.dart';
import 'package:primeiro_jogo/game/jogo.dart';

class ExplosionComponent extends SpriteAnimationComponent
    with HasGameReference<Jogo> {
  ExplosionComponent(double x, double y)
      : super(
          position: Vector2(x, y),
          size: Vector2.all(50),
          removeOnFinish: true,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    animation = await game.loadSpriteAnimation(
      'explosion.png',
      SpriteAnimationData.sequenced(
        stepTime: 0.1,
        amount: 6,
        loop: false,
        textureSize: Vector2.all(32),
      ),
    );
  }
}
