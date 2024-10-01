
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:primeiro_jogo/sprites/Polen.dart';

import '../Jogo.dart';

class Enemy extends SpriteAnimationComponent with HasGameRef<Jogo>, CollisionCallbacks{

  Enemy({super.position}) : super(
    size: Vector2.all(tamanho),
    anchor: Anchor.centerRight
  );

  static const tamanho = 80.0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    //Aqui é a animação do polen saindo da abelha.
    animation = await game.loadSpriteAnimation(
        "enemy.png",
        SpriteAnimationData.sequenced( // É possível gerar uma animação por meio de uma foto, apenas dizendo quantos frames são correspondentes
            amount: 3,
            stepTime: 1, // Tempo que vai durar cada frame
            textureSize: Vector2(32, 32) // Tamanho de cada frame
        )
    );

    //A colisão do inimgo tem que ser ativa, pois ele tem que verificar se tomou tiro. E há menor inimigos do que balas na tela. Aumentando o desempenho
    add(RectangleHitbox(size: Vector2(tamanho, tamanho)));

  }

  @override
  void update (double dt){
    super.update(dt);

    position.x += dt * -100;

    if(position.x < 0){
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other)
  {
    super.onCollisionStart(intersectionPoints, other);

    if(other is Polen){
      removeFromParent();
      other.removeFromParent();

    }
  }
}