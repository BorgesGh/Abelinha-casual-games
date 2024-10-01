
import 'package:flame/components.dart';

import '../Jogo.dart';

class Enemy extends SpriteAnimationComponent with HasGameRef<Jogo>{

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
  }

  @override
  void update (double dt){
    super.update(dt);

    position.x += dt * -100;

    if(position.x < 0){
      removeFromParent();
    }
  }

}