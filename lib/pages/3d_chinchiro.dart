import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:zflutter/zflutter.dart';

class Dices extends StatefulWidget {
  _DicesState createState() => _DicesState();
}

class _DicesState extends State<Dices> with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late SpringSimulation simulation;
  int num = 1;
  int num2 = 1;
  int num3 = 1;
  ZVector rotation = ZVector.zero;
  double zRotation = 0;
  double scoreFontSize = 36;

  @override
  void initState() {
    super.initState();

    simulation = SpringSimulation(
      const SpringDescription(
        mass: 1,
        stiffness: 20,
        damping: 2,
      ),
      1, // starting point
      0, // ending point
      1, // velocity
    );

    animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 2000))
          ..addListener(() {
            // rotation = rotation + ZVector.all(0.1);
            setState(() {});
          });
    // アニメーション完了時のリスナーを追加
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // アニメーションが終了したらダイアログを表示
        _showDialog();
      }
    });
  }

  void random() {
    zRotation = Random().nextDouble() * tau;
    num = Random().nextInt(6) + 1;
    num2 = Random().nextInt(6) + 1;
    num3 = Random().nextInt(6) + 1;
  }

  Widget _dialogScore(){
    List<int> diceNumbers = [num, num2, num3];
    if (num == num2 && num2 == num3 && num3 == 1) {
      // ピンゾロ
      return Text('ピンゾロ', style: TextStyle(fontSize: scoreFontSize), textAlign: TextAlign.center);
    } else if (num == num2 && num2 == num3) {
      // ゾロ目
      return Text('$numゾロ', style: TextStyle(fontSize: scoreFontSize), textAlign: TextAlign.center);
    } else if (diceNumbers.toSet().containsAll({4,5,6})) {
      // シゴロ
      return Text('シゴロ', style: TextStyle(fontSize: scoreFontSize), textAlign: TextAlign.center);
    } else if (diceNumbers.toSet().containsAll({1,2,3})) {
      // ヒフミ
      return Text('ヒフミ', style: TextStyle(fontSize: scoreFontSize), textAlign: TextAlign.center);
    } else if (num == num2) {
      // ふつうの目
      return Text('$num3', style: TextStyle(fontSize: scoreFontSize), textAlign: TextAlign.center);
    } else if (num2 == num3) {
      // ふつうの目
      return Text('$num', style: TextStyle(fontSize: scoreFontSize), textAlign: TextAlign.center);
    } else if (num == num3) {
      // ふつうの目
      return Text('$num2', style: TextStyle(fontSize: scoreFontSize), textAlign: TextAlign.center);
    } else {
      return Text('役なし', style: TextStyle(fontSize:scoreFontSize), textAlign: TextAlign.center);
    }
  }
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: _dialogScore(),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final curvedValue = CurvedAnimation(
      curve: Curves.ease,
      parent: animationController,
    );
    final firstHalf = CurvedAnimation(
      curve: const Interval(0, 1),
      parent: animationController,
    );
    final secondHalf = CurvedAnimation(
      curve: const Interval(0, 0.3),
      parent: animationController,
    );

    final zoom = (simulation.x(animationController.value)).abs() / 2 + 0.5;

    return GestureDetector(
      onTap: () {
        if (animationController.isAnimating) {
          animationController.reset();
        } else {
          animationController.forward(from: 0);
          random();
        }
      },
      child: Container(
        color: Colors.transparent,
        child: ZIllustration(
          zoom: 1.5,
          children: [
            ZPositioned(
              translate: ZVector.only(x: 100 * zoom),
              child: ZGroup(
                children: [
                  ZPositioned(
                    scale: ZVector.all(zoom),
                    rotate:
                        getRotation(num2).multiplyScalar(curvedValue.value) -
                            ZVector.all((tau / 2) * (firstHalf.value)) -
                            ZVector.all((tau / 2) * (secondHalf.value)),
                    child: ZPositioned(
                        rotate: ZVector.only(
                            z: -zRotation * 1.9 * (animationController.value)),
                        child: Dice(
                          zoom: zoom,
                          color: Colors.green,
                        )),
                  ),
                ],
              ),
            ),
            ZPositioned(
              translate: ZVector.only(x: -100 * zoom),
              child: ZGroup(
                children: [
                  ZPositioned(
                    scale: ZVector.all(zoom),
                    rotate: getRotation(num).multiplyScalar(curvedValue.value) -
                        ZVector.all((tau / 2) * (firstHalf.value)) -
                        ZVector.all((tau / 2) * (secondHalf.value)),
                    child: ZPositioned(
                        rotate: ZVector.only(
                            z: -zRotation * 2.1 * (animationController.value)),
                        child: Dice(
                          zoom: zoom,
                          color: Colors.blue,
                        )),
                  ),
                ],
              ),
            ),
            ZPositioned(
              translate: ZVector.only(x: zoom, y: -100 * zoom),
              child: ZGroup(
                children: [
                  ZPositioned(
                    scale: ZVector.all(zoom),
                    rotate: getRotation(num3).multiplyScalar(curvedValue.value) -
                        ZVector.all((tau / 2) * (firstHalf.value)) -
                        ZVector.all((tau / 2) * (secondHalf.value)),
                    child: ZPositioned(
                        rotate: ZVector.only(
                            z: -zRotation * 2.1 * (animationController.value)),
                        child: Dice(zoom: zoom)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

ZVector getRotation(int num) {
  switch (num) {
    case 1:
      return ZVector.zero;
    case 2:
      return const ZVector.only(x: tau / 4);
    case 3:
      return const ZVector.only(y: tau / 4);
    case 4:
      return const ZVector.only(y: 3 * tau / 4);
    case 5:
      return const ZVector.only(x: 3 * tau / 4);
    case 6:
      return const ZVector.only(y: tau / 2);
  }
  throw ('num $num is not in the dice');
}

class Face extends StatelessWidget {
  final double zoom;
  final Color color;

  const Face({super.key, this.zoom = 1, required this.color});

  @override
  Widget build(BuildContext context) {
    return ZRect(
      stroke: 50 * zoom,
      width: 50,
      height: 50,
      color: color,
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({super.key});

  @override
  Widget build(BuildContext context) {
    return ZCircle(
      diameter: 15,
      stroke: 0,
      fill: true,
      color: Colors.white,
    );
  }
}

class GroupTwo extends StatelessWidget {
  const GroupTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      sortMode: SortMode.update,
      children: const [
        ZPositioned(translate: ZVector.only(y: -20), child: Dot()),
        ZPositioned(translate: ZVector.only(y: 20), child: Dot()),
      ],
    );
  }
}

class GroupFour extends StatelessWidget {
  const GroupFour({super.key});

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      sortMode: SortMode.update,
      children: const [
        ZPositioned(translate: ZVector.only(x: 20, y: 0), child: GroupTwo()),
        ZPositioned(translate: ZVector.only(x: -20, y: 0), child: GroupTwo()),
      ],
    );
  }
}

class Dice extends StatelessWidget {
  final Color color;
  final double zoom;

  const Dice({super.key, this.zoom = 1, this.color = const Color(0xffF23726)});

  @override
  Widget build(BuildContext context) {
    return ZGroup(
      children: [
        ZGroup(
          sortMode: SortMode.update,
          children: [
            ZPositioned(
                translate: const ZVector.only(z: -25),
                child: Face(zoom: zoom, color: color)),
            ZPositioned(
                translate: const ZVector.only(z: 25),
                child: Face(zoom: zoom, color: color)),
            ZPositioned(
                translate: const ZVector.only(y: 25),
                rotate: const ZVector.only(x: tau / 4),
                child: Face(
                  zoom: zoom,
                  color: color,
                )),
            ZPositioned(
                translate: const ZVector.only(y: -25),
                rotate: const ZVector.only(x: tau / 4),
                child: Face(zoom: zoom, color: color)),
          ],
        ),
        //one
        const ZPositioned(translate: ZVector.only(z: 50), child: Dot()),
        //two
        ZPositioned(
          rotate: const ZVector.only(x: tau / 4),
          translate: const ZVector.only(y: 50),
          child: ZGroup(
            sortMode: SortMode.update,
            children: const [
              ZPositioned(translate: ZVector.only(y: -20), child: Dot()),
              ZPositioned(translate: ZVector.only(y: 20), child: Dot()),
            ],
          ),
        ),
        //three
        ZPositioned(
          rotate: const ZVector.only(y: tau / 4),
          translate: const ZVector.only(x: 50),
          child: ZGroup(
            sortMode: SortMode.update,
            children: const [
              Dot(),
              ZPositioned(translate: ZVector.only(x: 20, y: -20), child: Dot()),
              ZPositioned(translate: ZVector.only(x: -20, y: 20), child: Dot()),
            ],
          ),
        ),
        //four
        ZPositioned(
          rotate: const ZVector.only(y: tau / 4),
          translate: const ZVector.only(x: -50),
          child: ZGroup(
            sortMode: SortMode.update,
            children: const [
              ZPositioned(
                  translate: ZVector.only(x: 20, y: 0), child: GroupTwo()),
              ZPositioned(
                  translate: ZVector.only(x: -20, y: 0), child: GroupTwo()),
            ],
          ),
        ),

        //five
        ZPositioned(
          rotate: const ZVector.only(x: tau / 4),
          translate: const ZVector.only(y: -50),
          child: ZGroup(
            sortMode: SortMode.update,
            children: const [
              Dot(),
              ZPositioned(child: GroupFour()),
            ],
          ),
        ),

        //six
        ZPositioned(
          translate: const ZVector.only(z: -50),
          child: ZGroup(
            sortMode: SortMode.update,
            children: const [
              ZPositioned(rotate: ZVector.only(z: tau / 4), child: GroupTwo()),
              ZPositioned(child: GroupFour()),
            ],
          ),
        ),
      ],
    );
  }
}
