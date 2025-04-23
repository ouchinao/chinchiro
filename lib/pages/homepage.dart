// home画面 : ボタンで2dか3dか選択

import 'package:flutter/material.dart';
import '2d_chinchiro.dart';
import '3d_chinchiro.dart';
import '../device_type.dart';

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
    final deviceType = getDeviceType(context);
    return Scaffold(
      body: Center(
        child: deviceType == DeviceType.mobile
          ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buildButtons(context),
          )
          :Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: buildButtons(context),
        ),
      ),
    );
  }
	// ボタンまとめて、レスポンシブ対応かける
	List<Widget> buildButtons(BuildContext context){
		return [
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
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Dices(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: buttonPaddingHorizontal, vertical: buttonPaddingVertical),
          textStyle: const TextStyle(fontSize: buttonFontSize),
        ),
        child: const Text(threeDText),
      ),
		];
	}
}