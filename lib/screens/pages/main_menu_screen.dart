import 'package:flutter/material.dart';

class MainMenuPage extends StatelessWidget {
  final VoidCallback onStartGame;

  const MainMenuPage({super.key, required this.onStartGame});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellowAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Abelha guerreira',
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: onStartGame,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'Iniciar Jogo',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
