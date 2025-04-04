import 'package:flame/components.dart';
import 'package:primeiro_jogo/game/jogo.dart';
import 'package:primeiro_jogo/utils/assets.dart';

class ExplosionEffect extends SpriteAnimationComponent
    with HasGameReference<Jogo> {
  ExplosionEffect(double x, double y)
      : super(
          position: Vector2(x, y),
          size: Vector2.all(50),
          removeOnFinish: true,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    animation = await game.loadSpriteAnimation(
      Assets.explosion,
      SpriteAnimationData.sequenced(
        stepTime: 0.1,
        amount: 6,
        loop: false,
        textureSize: Vector2.all(32),
      ),
    );
  }
}
