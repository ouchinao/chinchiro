//
//  chinchiro
//
//  Created by 大内直 on 2024/08/13.
//  2DVer完成 on 2024/08/24
//
import 'dart:math';
import 'package:flutter/material.dart';
import 'device_type.dart';

//Scaffoldの中にStatefulWidgetを埋め込む
void main() {
  return runApp(
    MaterialApp(
      home:Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("ちんちろ"),
          backgroundColor: Colors.grey,
        ),
        drawer: Builder( // Builderを追加してcontextを取得
          builder: (BuildContext context) {
            return Drawer( // メニューバーを追加
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Text('メニュー'),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                  ),
                  ListTile(
                    title: Text('ルール'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RulesPage(), // ルールページに遷移
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
        body: DicePage(),
      ),
    ),
  );
}

// 変数を更新した時にStatefulWidgetも更新
class DicePage extends StatefulWidget{
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
      return Text('ピンゾロ', style: TextStyle(fontSize: 36));
    } else if (leftDiceNumber01 == leftDiceNumber02 && leftDiceNumber02 == leftDiceNumber03) {
      // ゾロ目
      return Text('$leftDiceNumber01のゾロ目', style: TextStyle(fontSize: 36));
    } else if (diceNumbers.toSet().containsAll({4,5,6})) {
      // シゴロ
      return Text('シゴロ', style: TextStyle(fontSize: 36));
    } else if (diceNumbers.toSet().containsAll({1,2,3})) {
      // ヒフミ
      return Text('ヒフミ', style: TextStyle(fontSize: 36));
    } else if (leftDiceNumber01 == leftDiceNumber02) {
      // ふつうの目
      return Text('$leftDiceNumber03のふつうの目', style: TextStyle(fontSize: 36));
    } else if (leftDiceNumber02 == leftDiceNumber03) {
      // ふつうの目
      return Text('$leftDiceNumber01のふつうの目', style: TextStyle(fontSize: 36));
    } else if (leftDiceNumber01 == leftDiceNumber03) {
      // ふつうの目
      return Text('$leftDiceNumber02のふつうの目', style: TextStyle(fontSize: 36));
    } else {
      return Text('役なし', style: TextStyle(fontSize:36));
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
              child: Icon(Icons.casino, size: 150, color: Colors.red), // サイコロのアイコン
            ),
          ],
        ),
      ),
    );
  }
}

// ルールページ
class RulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ルール'),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/rules.png"),
          ],
        ),
      ),
    );
  }
}