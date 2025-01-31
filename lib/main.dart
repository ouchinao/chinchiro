//
//  chinchiro
//
//  Created by 大内直 on 2024/08/13.
//  
//
import 'package:chinchiro/homepage.dart';
import 'package:flutter/material.dart';
import 'rule.dart';
import '2d_chinchiro.dart';
// import 'package:zflutter/zflutter.dart';

//Scaffoldの中にStatefulWidgetを埋め込む
void main() {
  return runApp(
    MaterialApp(
      home:Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("ちんちろ"),
          backgroundColor: Colors.grey,
        ),
        drawer: Builder( // Builderを追加してcontextを取得
          builder: (BuildContext context) {
            return Drawer( // メニューバーを追加
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Text('メニュー'),
                  ),
                  ListTile(
                    title: const Text('ルール'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RulesPage(), // ルールページに遷移
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
        body: const HomePage(),
      ),
    ),
  );
}