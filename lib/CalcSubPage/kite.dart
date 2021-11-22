import 'package:flutter/material.dart';
import 'package:geomath/numberField.dart';

enum KiteAreaFormula { fromCD, fromAB }

class KiteCalcPage extends StatefulWidget {
  KiteCalcPage({Key? key}) : super(key: key);

  @override
  _KiteCalcPage createState() => _KiteCalcPage();
}

class _KiteCalcPage extends State<KiteCalcPage> {
  KiteAreaFormula? _kiteAreaFormula = KiteAreaFormula.fromCD;

  bool showBottomMenu = true;
  final GlobalKey _widgetKey = GlobalKey();
  final GlobalKey _animatedPos = GlobalKey();
  Size? _size;

  var threshold = 100;

  getData() {
    switch (_kiteAreaFormula) {
      case KiteAreaFormula.fromCD:
        return CalcPageFromCD();
      case KiteAreaFormula.fromAB:
        return CalcPageFromAB();
      default:
        print("Invalid");
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
                              Column(
                                children: <Widget>[
                                  ListTile(
                                    title: const Text('หาพื้นที่'),
                                    leading: Radio<KiteAreaFormula>(
                                      value: KiteAreaFormula.fromCD,
                                      groupValue: _kiteAreaFormula,
                                      onChanged: (KiteAreaFormula? value) {
                                        setState(() {
                                          _kiteAreaFormula = value;
                                        });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: const Text('หาเส้นรอบรูป'),
                                    leading: Radio<KiteAreaFormula>(
                                      value: KiteAreaFormula.fromAB,
                                      groupValue: _kiteAreaFormula,
                                      onChanged: (KiteAreaFormula? value) {
                                        setState(() {
                                          _kiteAreaFormula = value;
                                        });
                                      },
                                    ),
                                  ),
                                  getData()
                                ],
                              ),
                            ],
                          )
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

class CalcPageFromCD extends StatefulWidget {
  CalcPageFromCD({Key? key}) : super(key: key);

  @override
  _CalcPageFromCD createState() => _CalcPageFromCD();
}

class _CalcPageFromCD extends State<CalcPageFromCD> {
  num c = 0;
  num d = 0;

  Widget build(BuildContext context) {
    return Column(children: [
      NumberField(
        labelText: "c",
        onChanged: (value) => {
          setState(() {
            c = double.parse(value);
          })
        },
      ),
      NumberField(
          labelText: "d",
          onChanged: (value) => {
                setState(() {
                  d = double.parse(value);
                })
              }),
      SizedBox(height: 10),
      Text(
        "พื้นที่",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      Text(
        "${0.5 * c * d}",
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
      ),
    ]);
  }
}

class CalcPageFromAB extends StatefulWidget {
  CalcPageFromAB({Key? key}) : super(key: key);

  @override
  _CalcPageFromAB createState() => _CalcPageFromAB();
}

class _CalcPageFromAB extends State<CalcPageFromAB> {
  num a = 0;
  num b = 0;

  Widget build(BuildContext context) {
    return Column(children: [
      NumberField(
          labelText: "a",
          onChanged: (value) => {
                setState(() {
                  a = double.parse(value);
                })
              }),
      NumberField(
        labelText: "b",
        onChanged: (value) => {
          setState(() {
            b = double.parse(value);
          })
        },
      ),
      SizedBox(height: 10),
      Text(
        "เส้นรอบรูป",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      Text(
        "${2 * (a + b)}",
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
      )
    ]);
  }
}
