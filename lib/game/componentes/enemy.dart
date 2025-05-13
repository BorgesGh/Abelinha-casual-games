import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:primeiro_jogo/game/componentes/Player.dart';
import 'package:primeiro_jogo/game/componentes/explosion.dart';
import 'package:primeiro_jogo/game/componentes/polen.dart';
import 'package:primeiro_jogo/game/jogo.dart';
import 'package:primeiro_jogo/utils/assets.dart';

class Enemy extends SpriteAnimationComponent
    with HasGameRef<Jogo>, CollisionCallbacks {
  static const enemySize = 80.0;
  Enemy({super.position})
      : super(size: Vector2.all(enemySize), anchor: Anchor.centerRight);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    //Animação do inimigo, no caso 3 sprites para o mesmo inimigo
    animation = await game.loadSpriteAnimation(
        Assets.enemy,
        SpriteAnimationData.sequenced(
            // É possível gerar uma animação por meio de uma foto, apenas dizendo quantos frames são correspondentes
            amount: 3,
            stepTime: 1, // Tempo que vai durar cada frame
            textureSize: Vector2(32, 32) // tamanho de cada frame
            ));

    //A colisão do inimgo tem que ser ativa, pois ele tem que verificar se foi atingido. E há menor inimigos do que polens na tela. Aumentando o desempenho
    add(RectangleHitbox(
        size: Vector2.all(enemySize), // O tamanho da Hitbox tem que ser menor
        position: Vector2(enemySize / 2, enemySize / 2),
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

    if (game.state == GameState.gameOver) {
      return;
    }
    // Verifica se o objeto colidido é um polen ou com o jogador
    if (other is Polen) {
      game.world.add(ExplosionEffect(
          (position.x - size.x / 2) - 30, position.y - size.y / 2));
      removeFromParent();
      other.removeFromParent();
      game.pontuacao.value++;
    } else if (other is Player) {
      game.gameOver();
    }
  }
}
