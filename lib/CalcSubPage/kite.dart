import 'dart:math';

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

  var valueA = TextEditingController();
  var valueB = TextEditingController();
  var valueC = TextEditingController();
  var valueD = TextEditingController();

  bool showBottomMenu = true;
  final GlobalKey _widgetKey = GlobalKey();
  final GlobalKey _animatedPos = GlobalKey();
  Size? _size;

  double area = 0;
  double peri = 0;

  bool isFromCdVisible = true;
  bool isFromAbVisible = false;

  var threshold = 100;

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    valueA.dispose();
    valueB.dispose();
    valueC.dispose();
    valueD.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => {_size = _widgetKey.currentContext?.size});
    double bottomConfig = (showBottomMenu) ? 0 : -(_size!.height - 30);

    calculateFromCd(String string) {
      double c = double.tryParse(valueC.text) ?? 0;
      double d = double.tryParse(valueD.text) ?? 0;

      if (c != 0 && d != 0) {
        setState(() {
          area = 0.5 * c * d;
          valueA.text = sqrt(pow((c / 2), 2) + pow((c / 2), 2)).toString();
          valueB.text =
              sqrt(pow((c / 2), 2) + pow((d - (c / 2)), 2)).toString();
        });
      }
    }

    calculateFromAb(String string) {
      double a = double.tryParse(valueA.text) ?? 0;
      double b = double.tryParse(valueB.text) ?? 0;
      double c = 0;

      c = a / sqrt(2);

      if (a != 0 && b != 0) {
        setState(() {
          peri = 2 * (a + b);
          valueC.text = c.toString();
          valueD.text = (sqrt(pow(b, 2) - pow(c, 2)) + c).toString();
        });
      }
    }

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
                        child: Column(children: [
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
                                          isFromCdVisible = true;
                                          isFromAbVisible = false;
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
                                          isFromCdVisible = false;
                                          isFromAbVisible = true;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                children: [
                                  Visibility(
                                      visible: isFromCdVisible,
                                      child: Positioned(
                                          child: Column(
                                        children: [
                                          NumberField(
                                            labelText: "c",
                                            onChanged: calculateFromCd,
                                            controller: valueC,
                                          ),
                                          NumberField(
                                            labelText: "d",
                                            onChanged: calculateFromCd,
                                            controller: valueD,
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "พื้นที่",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "$area",
                                            style: TextStyle(
                                                fontSize: 26,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ))),
                                  Visibility(
                                      visible: isFromAbVisible,
                                      child: Positioned(
                                          child: Column(children: [
                                        NumberField(
                                          labelText: "a",
                                          onChanged: calculateFromAb,
                                          controller: valueA,
                                        ),
                                        NumberField(
                                          labelText: "b",
                                          onChanged: calculateFromAb,
                                          controller: valueB,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "เส้นรอบรูป",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          "$peri",
                                          style: TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ])))
                                ],
                              ),
                            ],
                          ),
                        ])),
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
