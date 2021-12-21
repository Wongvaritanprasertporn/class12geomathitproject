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

  var valueA = TextEditingController();
  var valueB = TextEditingController();
  var valueC = TextEditingController();
  var valueS = TextEditingController();
  var valueH = TextEditingController();

  num area = 0;
  num peri = 0;

  bool showBottomMenu = true;
  final GlobalKey _widgetKey = GlobalKey();
  final GlobalKey _animatedPos = GlobalKey();
  Size? _size;

  bool isFromAhVisible = true;
  bool isFromAbcVisible = false;

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
    valueS.dispose();
    valueH.dispose();
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
      double h = double.tryParse(valueH.text) ?? 0;

      setState(() {
        area = (a * h) / 2;
      });
    }

    calculateFromAbc(String string) {
      double a = double.tryParse(valueA.text) ?? 0;
      double b = double.tryParse(valueB.text) ?? 0;
      double c = double.tryParse(valueC.text) ?? 0;
      double s = 0.5 * (a + b + c);

      setState(() {
        area = sqrt(s * (s - a) * (s - b) * (s - c));
        peri = a + b + c;
      });
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
                                          isFromAhVisible = true;
                                          isFromAbcVisible = false;
                                          valueA.text = "";
                                          valueB.text = "";
                                          valueC.text = "";
                                          area = 0;
                                          peri = 0;
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
                                          isFromAhVisible = false;
                                          isFromAbcVisible = true;
                                          valueA.text = "";
                                          valueH.text = "";
                                          area = 0;
                                          peri = 0;
                                        });
                                      },
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                            Stack(children: [
                              Visibility(
                                  visible: isFromAhVisible,
                                  child: Positioned(
                                      child: Column(
                                    children: [
                                      NumberField(
                                        labelText: "a",
                                        onChanged: calculateFromAh,
                                        controller: valueA,
                                      ),
                                      NumberField(
                                        labelText: "h (ความสูง)",
                                        onChanged: calculateFromAh,
                                        controller: valueH,
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
                                  visible: isFromAbcVisible,
                                  child: Positioned(
                                      child: Column(
                                    children: [
                                      NumberField(
                                        labelText: "a",
                                        onChanged: calculateFromAbc,
                                        controller: valueA,
                                      ),
                                      NumberField(
                                        labelText: "b",
                                        onChanged: calculateFromAbc,
                                        controller: valueB,
                                      ),
                                      NumberField(
                                        labelText: "c",
                                        onChanged: calculateFromAbc,
                                        controller: valueC,
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
                                    ],
                                  )))
                            ]),
                          ],
                        ))
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
