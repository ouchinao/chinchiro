// 2dでのちんちろ
// 変数を更新した時にStatefulWidgetも更新
import 'dart:math';
import 'package:flutter/material.dart';
import '../device_type.dart';

const int firstleftDiceNumber01 = 1;
const int firstleftDiceNumber02 = 6;
const int firstleftDiceNumber03 = 3;
const int randomDice = 6;
const double scoreFontSize = 36;
const double dicePadding = 5.0;
const double diceHeightRate = 0.5;
const double diceIconButtonSize = 150;


class DicePage extends StatefulWidget{
  const DicePage({super.key});

  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDiceNumber01 = firstleftDiceNumber01;
  int leftDiceNumber02 = firstleftDiceNumber02;
  int leftDiceNumber03 = firstleftDiceNumber03;

  void _changeDiceFace(){
    setState((){
      leftDiceNumber01 = Random().nextInt(randomDice) + 1;
      leftDiceNumber02 = Random().nextInt(randomDice) + 1;
      leftDiceNumber03 = Random().nextInt(randomDice) + 1;
    });
  }

  Widget _dialogScore(){
    List<int> diceNumbers = [leftDiceNumber01, leftDiceNumber02, leftDiceNumber03];
    if (leftDiceNumber01 == leftDiceNumber02 && leftDiceNumber02 == leftDiceNumber03 && leftDiceNumber03 == 1) {
      // ピンゾロ
      return const Text('ピンゾロ', style: TextStyle(fontSize: scoreFontSize));
    } else if (leftDiceNumber01 == leftDiceNumber02 && leftDiceNumber02 == leftDiceNumber03) {
      // ゾロ目
      return Text('$leftDiceNumber01ゾロ', style: const TextStyle(fontSize: scoreFontSize));
    } else if (diceNumbers.toSet().containsAll({4,5,6})) {
      // シゴロ
      return const Text('シゴロ', style: TextStyle(fontSize: scoreFontSize));
    } else if (diceNumbers.toSet().containsAll({1,2,3})) {
      // ヒフミ
      return const Text('ヒフミ', style: TextStyle(fontSize: scoreFontSize));
    } else if (leftDiceNumber01 == leftDiceNumber02) {
      // ふつうの目
      return Text('$leftDiceNumber03', style: const TextStyle(fontSize: scoreFontSize));
    } else if (leftDiceNumber02 == leftDiceNumber03) {
      // ふつうの目
      return Text('$leftDiceNumber01', style: const TextStyle(fontSize: scoreFontSize));
    } else if (leftDiceNumber01 == leftDiceNumber03) {
      // ふつうの目
      return Text('$leftDiceNumber02', style: const TextStyle(fontSize: scoreFontSize));
    } else {
      return const Text('役なし', style: TextStyle(fontSize:scoreFontSize));
    }
  }

  @override
  Widget build(BuildContext context){
    // サイコロ表示
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: dicePadding),
              child: SizedBox(
                width: getDialogWidth(context),
                height: getDialogHeight(context) * diceHeightRate,
                child: Image(
                  image: AssetImage("assets/dice$leftDiceNumber02.png"),
                ),    
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(dicePadding),
                    child: SizedBox(
                      width: getDialogWidth(context),
                      height: getDialogHeight(context) * diceHeightRate,
                      child: Image(
                        image: AssetImage("assets/dice$leftDiceNumber01.png"),
                      ),    
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    // スコア
                    child: _dialogScore(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(dicePadding),
                    child: SizedBox(
                      width: getDialogWidth(context),
                      height: getDialogHeight(context) * diceHeightRate,
                      child: Image(
                        image: AssetImage("assets/dice$leftDiceNumber03.png"),
                      ),    
                    ),
                  ),
                ),
              ],
            ),
            // サイコロを振るボタン
            ElevatedButton(
              onPressed: _changeDiceFace,
              child: const Icon(Icons.casino, size: diceIconButtonSize, color: Colors.red), // サイコロのアイコン
            ),
          ],
        ),
      ),
    );
  }
}