// home画面 : ボタンで2dか3dか選択

import 'package:flutter/material.dart';
import '2d_chinchiro.dart';

const double buttonPaddingHorizontal = 96.0;
const double buttonPaddingVertical = 48.0;
const double buttonFontSize = 40.0;
const double betweenButton = 30.0;
const String twoDText = "2D";
const String threeDText = "3D";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                padding: const EdgeInsets.symmetric(horizontal: buttonPaddingHorizontal, vertical: buttonPaddingVertical),
                textStyle: const TextStyle(fontSize: buttonFontSize),
              ),
              child: const Text(twoDText),
            ),
            const SizedBox(width: betweenButton),
            ElevatedButton(
              onPressed: () {
                // 実装まだ
                Navigator.pushNamed(context, '/3d_chinchiro');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: buttonPaddingHorizontal, vertical: buttonPaddingVertical),
                textStyle: const TextStyle(fontSize: buttonFontSize),
              ),
              child: const Text(threeDText),
            ),
          ],
        ),
      ),
    );
  }
}