//
//  chinchiro
//
//  Created by 大内直 on 2024/08/13.
//  Todo サイコロが振れるように 
//
import 'dart:math';
import 'package:flutter/material.dart';

//Scaffoldの中にStatefulWidgetを埋め込む
void main() {
  return runApp(
    MaterialApp(
      home:Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Chinchiro"),
          backgroundColor: Colors.grey,
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
              child: Image(
                image: AssetImage("assets/dice$leftDiceNumber02.png"),
              ),     
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image(
                      image: AssetImage("assets/dice$leftDiceNumber01.png"),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image(
                      image: AssetImage("assets/dice$leftDiceNumber03.png"),
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