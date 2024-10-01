
import 'package:flame/components.dart';
import 'package:primeiro_jogo/Jogo.dart';

//Note que o Polen está herndando de SpriteAnimation
class Polen extends SpriteAnimationComponent with HasGameRef<Jogo>{

  Polen({super.position}) : super (

    //Definindo o tamanho do spirte
    size: Vector2(80, 80),
    anchor: Anchor.centerLeft
  );

  @override
  Future<void> onLoad() async{
    await super.onLoad();

    //Aqui é a animação do polen saindo da abelha.
    animation = await game.loadSpriteAnimation(
      "polen.png",
      SpriteAnimationData.sequenced( // É possível gerar uma animação por meio de uma foto, apenas dizendo quantos frames são correspondentes
        amount: 4,
        stepTime: .2, // Tempo que vai durar cada frame
        textureSize: Vector2(32, 32) // Tamanho de cada frame
      )
    );

  }

  @override
  void update(double dt){
    super.update(dt);

    //O Tiro sair da tela
    position.x += dt * 100;

    if(position.x < -width){
      removeFromParent();
    }
  }

}