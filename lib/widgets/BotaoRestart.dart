import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class BotaoRestart extends PositionComponent with TapCallbacks{
  late Rect buttonRect;
  late Paint buttonPaint;
  late TextComponent buttonText;

  late final VoidCallback onRestart;

  BotaoRestart({required this.onRestart}) : super(priority: 21);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    priority = 25;

    // Define a cor do botão
    buttonPaint = Paint()..color = Colors.blue;

    // Cria um texto para ser exibido no botão
    buttonText = TextComponent(
      text: 'Clique-me',
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      ),
    );

    // Centraliza o texto no botão
    buttonText.position = size / 2 - buttonText.size / 2;
    add(buttonText);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Desenha o retângulo do botão
    canvas.drawRect(size.toRect(), buttonPaint);
  }

  @override
  void onTapDown(TapDownEvent event) {
    onRestart();
  }
}