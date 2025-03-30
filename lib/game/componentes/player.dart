import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:primeiro_jogo/game/componentes/polen.dart';
import 'package:primeiro_jogo/game/jogo.dart';
import 'package:primeiro_jogo/utils/Assets.dart';

class Player extends SpriteComponent with HasGameRef<Jogo> {
  static const double playerSize = 90.0;
  late Vector2 _posicaoInicial;
  late final SpawnComponent _polenSpawner; //Criador de polens

  Player() : super(size: Vector2.all(playerSize), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _posicaoInicial = Vector2((-(gameRef.size.x / 2)) + 20,
        0); //O sinal negativo serve para inverter o lado, no caso esquerdo.

    sprite = await gameRef.loadSprite(
        Assets.abelha); // A classe SpriteComponent tem o atributo Sprite

    position = _posicaoInicial;

    // Declaração de como o Spawner de polen irá funcionar
    _polenSpawner = SpawnComponent(
        period: 1, // Cadência
        selfPositioning: true,
        factory: (index) {
          return Polen(position: position + Vector2(20, 0));
        },
        autoStart: false);

    game.world.add(_polenSpawner); // Adiciona o Spawner no mundo

    add(RectangleHitbox(
        // O tamanho da Hitbox tem que ser menor
        size: Vector2(playerSize - 25, playerSize - 30),
        // O Tipo passivo indica que o objeto pode ser tocado por outro objeto.
        collisionType: CollisionType.passive,
        // Centraliza o ponto de referência
        position: Vector2(width / 2, height / 2),
        // Indica qual é o ponto de referência da HitBox, nesse caso o ponto de alinhamento é o centro.
        anchor: Anchor.center));
  }

  @override
  void onGameResize(Vector2 size) {
    // Atualiza a posição inicial do jogador quando o tamanho do jogo muda
    _posicaoInicial = Vector2((-(size.x / 2)) + 20, 0);
    super.onGameResize(size);
  }

  void reset() {
    position = _posicaoInicial;
    priority = 0;
  }

  void move(Vector2 pos) {
    position.add(pos);
  }

  //Funções de disparar o polen

  void startPolen() {
    // Inicia o Spawner de polen
    _polenSpawner.timer.start();
  }

  void stopPolen() {
    _polenSpawner.timer.stop();
  }

  //GameOver
  void gameOver() {
    _polenSpawner.timer.stop();
    removeWhere((component) => component is Polen);
  }
}
