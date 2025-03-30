import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:primeiro_jogo/game/jogo.dart';
import 'package:primeiro_jogo/utils/assets.dart';

//Note que o Polen está herndando de SpriteAnimation

class Polen extends SpriteAnimationComponent with HasGameRef<Jogo> {
  static const polenSize = 80.0;

  Polen({super.position})
      : super(

            //Definindo o polenSize do sprite
            size: Vector2(polenSize, polenSize),
            anchor: Anchor.centerLeft);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    //Aqui é a animação do polen saindo da abelha.
    animation = await game.loadSpriteAnimation(
        Assets.polen,
        SpriteAnimationData.sequenced(
            // É possível gerar uma animação por meio de uma foto, apenas dizendo quantos frames são correspondentes
            amount: 4,
            stepTime: .2, // Tempo que vai durar cada frame
            textureSize: Vector2(32, 32) // polenSize de cada frame
            ));

    //A colisão do Polen tem que ser passiva para ele apenas colidir com algo ativo.
    add(RectangleHitbox(
        size: Vector2.all(
            polenSize - 40), // O tamanho da Hitbox tem que ser menor
        collisionType: CollisionType.passive,
        anchor: Anchor.center,
        position: Vector2(width / 2, height / 2)));
  }

  @override
  void update(double dt) {
    super.update(dt);

    //Avançando o polen para a direita da tela
    position.x += dt * 100;

    if (position.x > (gameRef.size.x / 2) + 50) {
      removeFromParent();
    }

    if (GameState.gameOver == gameRef.state) {
      removeFromParent();
    }
  }
}
