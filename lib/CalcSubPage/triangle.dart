import 'package:flutter/material.dart';
import 'package:geomath/numberField.dart';
import 'dart:math';

enum TriangleAreaFormula { fromAH, fromSide }

class TriangleCalcPage extends StatefulWidget {
  TriangleCalcPage({Key? key}) : super(key: key);

  @override
  _TriangleCalcPage createState() => _TriangleCalcPage();
}

class _TriangleCalcPage extends State<TriangleCalcPage> {
  TriangleAreaFormula? _triangleAreaFormula = TriangleAreaFormula.fromAH;

  bool showBottomMenu = true;
  final GlobalKey _widgetKey = GlobalKey();
  final GlobalKey _animatedPos = GlobalKey();
  Size? _size;

  var threshold = 100;

  getData() {
    switch (_triangleAreaFormula) {
      case TriangleAreaFormula.fromAH:
        return CalcPageFromAH();
      case TriangleAreaFormula.fromSide:
        return CalcPageFromSide();
      default:
        print("invalid");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => {_size = _widgetKey.currentContext?.size});
    double bottomConfig = (showBottomMenu) ? 0 : -(_size!.height - 30);

    return Container(
      child: Stack(children: [
        AnimatedPositioned(
          key: _animatedPos,
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 200),
          left: 0,
          bottom: bottomConfig,
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
            child: Container(
              key: _widgetKey,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black38,
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              width: width,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.keyboard_arrow_up,
                      size: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Column(children: <Widget>[
                                ListTile(
                                  title: const Text(
                                      'เมื่อทราบความกว้างและความสูง'),
                                  leading: Radio<TriangleAreaFormula>(
                                    value: TriangleAreaFormula.fromAH,
                                    groupValue: _triangleAreaFormula,
                                    onChanged: (TriangleAreaFormula? value) {
                                      setState(() {
                                        _triangleAreaFormula = value;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                  title: const Text(
                                      'เมื่อทราบความความยาวของด้านทั้งสาม'),
                                  leading: Radio<TriangleAreaFormula>(
                                    value: TriangleAreaFormula.fromSide,
                                    groupValue: _triangleAreaFormula,
                                    onChanged: (TriangleAreaFormula? value) {
                                      setState(() {
                                        _triangleAreaFormula = value;
                                      });
                                    },
                                  ),
                                ),
                              ]),
                            ],
                          ),
                          getData(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class CalcPageFromAH extends StatefulWidget {
  CalcPageFromAH({Key? key}) : super(key: key);

  @override
  _CalcPageFromAH createState() => _CalcPageFromAH();
}

class _CalcPageFromAH extends State<CalcPageFromAH> {
  num a = 0;
  num h = 0;

  Widget build(BuildContext context) {
    return Column(
      children: [
        NumberField(
            labelText: "a",
            onChanged: (value) => {
                  setState(() {
                    a = double.parse(value);
                  })
                }),
        NumberField(
            labelText: "h (ความสูง)",
            onChanged: (value) => {
                  setState(() {
                    h = double.parse(value);
                  })
                }),
        SizedBox(height: 10),
        Text(
          "พื้นที่",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          "${(a * h) / 2}",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class CalcPageFromSide extends StatefulWidget {
  CalcPageFromSide({Key? key}) : super(key: key);

  @override
  _CalcPageFromSide createState() => _CalcPageFromSide();
}

class _CalcPageFromSide extends State<CalcPageFromSide> {
  num a = 0;
  num b = 0;
  num c = 0;
  num s = 0;

  Widget build(BuildContext context) {
    return Column(
      children: [
        NumberField(
            labelText: "a",
            onChanged: (value) => {
                  setState(() {
                    a = double.parse(value);
                    s = 0.5 * (a + b + c);
                  })
                }),
        NumberField(
            labelText: "b",
            onChanged: (value) => {
                  setState(() {
                    b = double.parse(value);
                    s = 0.5 * (a + b + c);
                  })
                }),
        NumberField(
            labelText: "c",
            onChanged: (value) => {
                  setState(() {
                    c = double.parse(value);
                    s = 0.5 * (a + b + c);
                  })
                }),
        SizedBox(height: 10),
        Text(
          "พื้นที่",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          "${sqrt(s * (s - a) * (s - b) * (s - c))}",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        Text(
          "เส้นรอบรูป",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          "${a + b + c}",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
