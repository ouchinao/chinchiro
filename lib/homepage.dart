// home画面 : ボタンで2dか3dか選択

import 'package:flutter/material.dart';
import '2d_chinchiro.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DicePage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 96, vertical: 48),
                textStyle: const TextStyle(fontSize: 40),
              ),
              child: const Text('2D'),
            ),
            const SizedBox(width: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/3d_chinchiro');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 96, vertical: 48),
                textStyle: const TextStyle(fontSize: 40),
              ),
              child: const Text('3D'),
            ),
          ],
        ),
      ),
    );
  }
}