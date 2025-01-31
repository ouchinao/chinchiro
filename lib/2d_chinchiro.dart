// 2dでのちんちろ
// 変数を更新した時にStatefulWidgetも更新
import 'dart:math';
import 'package:flutter/material.dart';
import 'device_type.dart';

class DicePage extends StatefulWidget{
  const DicePage({super.key});

  @override
  _DicePageState createState() => _DicePageState();
}

//ウィジェットの中のクラスをオーバーライド
class _DicePageState extends State<DicePage> {
  int leftDiceNumber01 = 1;
  int leftDiceNumber02 = 6;
  int leftDiceNumber03 = 3;

  void _changeDiceFace(){
    setState((){
      leftDiceNumber01 = Random().nextInt(6) + 1;
      leftDiceNumber02 = Random().nextInt(6) + 1;
      leftDiceNumber03 = Random().nextInt(6) + 1;
    });
  }

  Widget _dialogScore(){
    List<int> diceNumbers = [leftDiceNumber01, leftDiceNumber02, leftDiceNumber03];
    if (leftDiceNumber01 == leftDiceNumber02 && leftDiceNumber02 == leftDiceNumber03 && leftDiceNumber03 == 1) {
      // ピンゾロ
      return const Text('ピンゾロ', style: TextStyle(fontSize: 36));
    } else if (leftDiceNumber01 == leftDiceNumber02 && leftDiceNumber02 == leftDiceNumber03) {
      // ゾロ目
      return Text('$leftDiceNumber01ゾロ', style: const TextStyle(fontSize: 36));
    } else if (diceNumbers.toSet().containsAll({4,5,6})) {
      // シゴロ
      return const Text('シゴロ', style: TextStyle(fontSize: 36));
    } else if (diceNumbers.toSet().containsAll({1,2,3})) {
      // ヒフミ
      return const Text('ヒフミ', style: TextStyle(fontSize: 36));
    } else if (leftDiceNumber01 == leftDiceNumber02) {
      // ふつうの目
      return Text('$leftDiceNumber03', style: const TextStyle(fontSize: 36));
    } else if (leftDiceNumber02 == leftDiceNumber03) {
      // ふつうの目
      return Text('$leftDiceNumber01', style: const TextStyle(fontSize: 36));
    } else if (leftDiceNumber01 == leftDiceNumber03) {
      // ふつうの目
      return Text('$leftDiceNumber02', style: const TextStyle(fontSize: 36));
    } else {
      return const Text('役なし', style: TextStyle(fontSize:36));
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
              padding: const EdgeInsets.only(bottom: 5.0),
              child: SizedBox(
                width: getDialogWidth(context),
                height: getDialogHeight(context) * 0.5,
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
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      width: getDialogWidth(context),
                      height: getDialogHeight(context) * 0.5,
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
                    padding: const EdgeInsets.all(5.0),
                    child: SizedBox(
                      width: getDialogWidth(context),
                      height: getDialogHeight(context) * 0.5,
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
              child: const Icon(Icons.casino, size: 150, color: Colors.red), // サイコロのアイコン
            ),
          ],
        ),
      ),
    );
  }
}