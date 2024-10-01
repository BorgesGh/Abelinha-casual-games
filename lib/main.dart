import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:primeiro_jogo/Jogo.dart';

void main() {


  runApp(
      GameWidget(
        game: Jogo(),

      )
  );
}

