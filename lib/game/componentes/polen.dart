import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:primeiro_jogo/game/jogo.dart';

//Note que o Polen está herndando de SpriteAnimation
class Polen extends SpriteAnimationComponent with HasGameRef<Jogo> {
  Polen({super.position})
      : super(

            //Definindo o tamanho do spirte
            size: Vector2(tamanho, tamanho),
            anchor: Anchor.centerLeft);

  static const tamanho =
      80.0; // O Compilador está entendendo que o tamanho do jogo é esse... por isso o tiro some.

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    //Aqui é a animação do polen saindo da abelha.
    animation = await game.loadSpriteAnimation(
        "polen.png",
        SpriteAnimationData.sequenced(
            // É possível gerar uma animação por meio de uma foto, apenas dizendo quantos frames são correspondentes
            amount: 4,
            stepTime: .2, // Tempo que vai durar cada frame
            textureSize: Vector2(32, 32) // Tamanho de cada frame
            ));

    //A colisão da bala tem que ser passiva para ela apenas colidir com algo ativo.
    add(RectangleHitbox(
        size: Vector2.all(tamanho - 40),
        collisionType: CollisionType.passive,
        anchor: Anchor.center,
        position: Vector2(width / 2, height / 2)));
  }

  @override
  void update(double dt) {
    super.update(dt);

    //O Tiro sair da tela
    position.x += dt * 100;

    // print("O tamanho da tela: $width a posição do polen ${position.x}");
    if (position.x > (gameRef.size.x / 2) + 50) {
      removeFromParent();
    }

    if (GameState.gameOver == gameRef.state) {
      removeFromParent();
    }
  }
}
