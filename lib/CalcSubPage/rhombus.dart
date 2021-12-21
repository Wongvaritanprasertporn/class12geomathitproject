import 'package:flutter/material.dart';
import 'package:geomath/numberField.dart';
import 'dart:math';

enum RhombusAreaFormula { fromAH, fromBC }

class RhombusCalcPage extends StatefulWidget {
  RhombusCalcPage({Key? key}) : super(key: key);

  @override
  _RhombusCalcPage createState() => _RhombusCalcPage();
}

class _RhombusCalcPage extends State<RhombusCalcPage> {
  var valueA = TextEditingController();
  var valueH = TextEditingController();
  var valueB = TextEditingController();
  var valueC = TextEditingController();

  num area = 0;
  num peri = 0;

  RhombusAreaFormula? _rhombusAreaFormula = RhombusAreaFormula.fromAH;
  bool showBottomMenu = true;
  final GlobalKey _widgetKey = GlobalKey();
  final GlobalKey _animatedPos = GlobalKey();
  Size? _size;

  var threshold = 100;

  bool isFromAhVisible = true;
  bool isFromBcVisible = false;

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    valueA.dispose();
    valueH.dispose();
    valueB.dispose();
    valueC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => {_size = _widgetKey.currentContext?.size});
    double bottomConfig = (showBottomMenu) ? 0 : -(_size!.height - 30);

    calculateFromAh(String string) {
      double a = double.tryParse(valueA.text) ?? 0;
      double b = 0;
      double h = double.tryParse(valueH.text) ?? 0;

      if (a != 0 && h != 0) {
        setState(() {
          area = a * h;
          peri = 4 * a;
          b = sqrt(pow(a - sqrt(pow(a, 2) - pow(h, 2)), 2) + pow(h, 2));
          valueB.text = b.toString();
          valueC.text = (sqrt(pow(a, 2) - pow((b / 2), 2)) * 2).toString();
        });
      }
    }

    calculateFromBc(String string) {
      double a = 0;
      double b = double.tryParse(valueB.text) ?? 0;
      double c = double.tryParse(valueC.text) ?? 0;

      if (b != 0 && c != 0) {
        setState(() {
          area = 0.5 * b * c;
          a = sqrt(pow(b / 2, 2) + pow(c / 2, 2));
          peri = 4 * a;
          valueA.text = a.toString();
          valueH.text = (area / a).toString();
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
                child: Column(children: <Widget>[
                  Icon(
                    Icons.keyboard_arrow_up,
                    size: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(children: [
                      Column(
                        children: <Widget>[
                          ListTile(
                            title: const Text('เมื่อทราบความยาวด้านและความสูง'),
                            leading: Radio<RhombusAreaFormula>(
                              value: RhombusAreaFormula.fromAH,
                              groupValue: _rhombusAreaFormula,
                              onChanged: (RhombusAreaFormula? value) {
                                setState(() {
                                  _rhombusAreaFormula = value;
                                  isFromAhVisible = true;
                                  isFromBcVisible = false;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text(
                                'เมื่อทราบความยาวเส้นทแยงมุมทั้งสองเส้น'),
                            leading: Radio<RhombusAreaFormula>(
                              value: RhombusAreaFormula.fromBC,
                              groupValue: _rhombusAreaFormula,
                              onChanged: (RhombusAreaFormula? value) {
                                setState(() {
                                  _rhombusAreaFormula = value;
                                  isFromAhVisible = false;
                                  isFromBcVisible = true;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Stack(children: [
                        Visibility(
                          visible: isFromAhVisible,
                          child: Positioned(
                            child: Column(
                              children: [
                                NumberField(
                                  labelText: "a (ด้าน)",
                                  onChanged: calculateFromAh,
                                  controller: valueA,
                                ),
                                NumberField(
                                  labelText: "h (ความสูง)",
                                  onChanged: calculateFromAh,
                                  controller: valueH,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isFromBcVisible,
                          child: Positioned(
                            child: Column(
                              children: [
                                NumberField(
                                  labelText: "b",
                                  onChanged: calculateFromBc,
                                  controller: valueB,
                                ),
                                NumberField(
                                  labelText: "c",
                                  onChanged: calculateFromBc,
                                  controller: valueC,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                      Text(
                        "พื้นที่",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "$area",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "เส้นรอบรูป",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "$peri",
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.bold),
                      )
                    ]),
                  ),
                ]),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
