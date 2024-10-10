
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Jogo.dart';

class OverlayScreen extends StatelessWidget{
  const OverlayScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.game
  });
  final Jogo game;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, -0.15),
      child: Container(
        width: 400,
        height: 500,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.yellow,
          borderRadius: BorderRadius.all(Radius.circular(35.5))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 40,
                color: Colors.black,
                decoration: TextDecoration.none
              )

            ),
            const SizedBox(height: 16),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            ElevatedButton(
              onPressed: (){
                game.restart();
              },
              child: const Text("Restart!"))
          ],
        ),
      ),
    );
  }
  
  
}