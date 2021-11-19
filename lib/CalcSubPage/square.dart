import 'package:flutter/material.dart';
import 'package:geomath/numberField.dart';
import 'dart:math';

enum SquareAreaFormula { fromA, fromB }

class SquareCalcPage extends StatefulWidget {
  SquareCalcPage({Key? key}) : super(key: key);

  @override
  _SquareCalcPage createState() => _SquareCalcPage();
}

class _SquareCalcPage extends State<SquareCalcPage> {
  SquareAreaFormula? _squareAreaFormula = SquareAreaFormula.fromA;

  bool showBottomMenu = true;
  final GlobalKey _widgetKey = GlobalKey();
  Size? _size;

  var threshold = 100;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => {_size = _widgetKey.currentContext?.size});
  }

  getData() {
    switch (_squareAreaFormula) {
      case SquareAreaFormula.fromA:
        return CalcPageFromA();
      case SquareAreaFormula.fromB:
        return CalcPageFromB();
      default:
        print("Unknown square area formula");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      child: Stack(children: [
        AnimatedPositioned(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 200),
            left: 0,
            bottom: (showBottomMenu) ? 0 : -(_size!.height - 30),
            child: GestureDetector(
              onPanEnd: (details) {
                if (details.velocity.pixelsPerSecond.dy > threshold) {
                  this.setState(() {
                    showBottomMenu = false;
                  });
                  print(details.velocity.pixelsPerSecond.dy.toString());
                } else if (details.velocity.pixelsPerSecond.dy < -threshold) {
                  this.setState(() {
                    showBottomMenu = true;
                  });
                  print(details.velocity.pixelsPerSecond.dy.toString());
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                child: Container(
                  key: _widgetKey,
                  width: width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 10),
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.keyboard_arrow_up,
                          size: 20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  ListTile(
                                    title: const Text("เมื่อทราบความยาวด้าน"),
                                    leading: Radio<SquareAreaFormula>(
                                      value: SquareAreaFormula.fromA,
                                      groupValue: _squareAreaFormula,
                                      onChanged: (SquareAreaFormula? value) {
                                        setState(() {
                                          _squareAreaFormula = value;
                                        });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: const Text(
                                        "เมื่อทราบความยาวเส้นทแยงมุม"),
                                    leading: Radio<SquareAreaFormula>(
                                      value: SquareAreaFormula.fromB,
                                      groupValue: _squareAreaFormula,
                                      onChanged: (SquareAreaFormula? value) {
                                        setState(() {
                                          _squareAreaFormula = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Container(child: getData())
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ))
      ]),
    );
  }
}

class CalcPageFromA extends StatefulWidget {
  CalcPageFromA({Key? key}) : super(key: key);

  @override
  _CalcPageFromA createState() => _CalcPageFromA();
}

class _CalcPageFromA extends State<CalcPageFromA> {
  num numberFieldValA = 0;

  Widget build(BuildContext context) {
    return Column(
      children: [
        NumberField(
          labelText: "a",
          onChanged: (value) => {
            setState(() {
              numberFieldValA = double.parse(value);
            })
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              Text(
                "พื้นที่",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "${pow(numberFieldValA, 2)}",
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              Text(
                "เส้นรอบรูป",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "${numberFieldValA * 4}",
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CalcPageFromB extends StatefulWidget {
  CalcPageFromB({Key? key}) : super(key: key);

  @override
  _CalcPageFromB createState() => _CalcPageFromB();
}

class _CalcPageFromB extends State<CalcPageFromB> {
  num numberFieldValB = 0;
  Widget build(BuildContext context) {
    return Column(
      children: [
        NumberField(
          labelText: "b",
          onChanged: (value) => {
            setState(() {
              numberFieldValB = double.parse(value);
            })
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              Text(
                "พื้นที่",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "${0.5 * pow(numberFieldValB, 2)}",
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ],
    );
  }
}
