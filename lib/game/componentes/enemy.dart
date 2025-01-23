import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:primeiro_jogo/game/componentes/Player.dart';
import 'package:primeiro_jogo/game/componentes/polen.dart';
import 'package:primeiro_jogo/game/jogo.dart';

class Enemy extends SpriteAnimationComponent
    with HasGameRef<Jogo>, CollisionCallbacks {
  Enemy({super.position})
      : super(size: Vector2.all(tamanho), anchor: Anchor.centerRight);

  static const tamanho = 80.0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    //Aqui é a animação do polen saindo da abelha.
    animation = await game.loadSpriteAnimation(
        "enemy.png",
        SpriteAnimationData.sequenced(
            // É possível gerar uma animação por meio de uma foto, apenas dizendo quantos frames são correspondentes
            amount: 3,
            stepTime: 1, // Tempo que vai durar cada frame
            textureSize: Vector2(32, 32) // Tamanho de cada frame
            ));

    //A colisão do inimgo tem que ser ativa, pois ele tem que verificar se tomou tiro. E há menor inimigos do que balas na tela. Aumentando o desempenho
    add(RectangleHitbox(
        size: Vector2(tamanho, tamanho),
        position: Vector2(tamanho / 2, tamanho / 2),
        anchor: Anchor.center));
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.x += dt * -100;

    if (position.x < -(gameRef.size.x / 2)) {
      removeFromParent();
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Polen) {
      removeFromParent();
      other.removeFromParent();
      game.pontuacao.value++;
    } else if (other is Player) {
      print("Game Over");
      FlameAudio.bgm.stop();
      FlameAudio.bgm.play("derrotaMusic.mp3");
      game.gameOver();
    }
  }
}
