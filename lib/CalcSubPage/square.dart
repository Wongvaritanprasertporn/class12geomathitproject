import 'package:geomath/numberFieldController.dart';
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

  var valueA = NumberFieldController();
  var valueB = NumberFieldController();

  bool showBottomMenu = true;
  final GlobalKey _widgetKey = GlobalKey();
  final GlobalKey _animatedPos = GlobalKey();
  Size? _size;

  var threshold = 100;

  bool isFromAVisible = true;
  bool isFromBVisible = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double bottomConfig = (showBottomMenu) ? 0 : -(_size!.height - 30);
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => {_size = _widgetKey.currentContext?.size});

    num area = 0.0;
    num peri = 0.0;

    calculate() {
      /*if (_squareAreaFormula == SquareAreaFormula.fromA) {
        setState(() {
          area = pow(valueA.number, 2);
          peri = valueA.number * 4;
          valueB.number = sqrt(pow(valueA.number, 2) * 2);
        });
      } else if (_squareAreaFormula == SquareAreaFormula.fromB) {
        setState(() {
          area = 0.5 * pow(valueB.number, 2);
          peri = sqrt(0.5 * pow(valueB.number, 2)) * 4;
          valueA.number = sqrt(pow(valueB.number, 2) / 2);
        });
      }*/
      print("wow");
    }

    return Container(
      child: Stack(children: [
        Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: CustomPaint(
            painter: GraphicsVisual(),
          ),
        ),
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
                color: Colors.white,
                border: Border.all(color: Colors.black38),
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
                              ListTile(
                                title: const Text("เมื่อทราบความยาวด้าน"),
                                leading: Radio<SquareAreaFormula>(
                                  value: SquareAreaFormula.fromA,
                                  groupValue: _squareAreaFormula,
                                  onChanged: (SquareAreaFormula? value) {
                                    setState(() {
                                      _squareAreaFormula = value;
                                      isFromAVisible = true;
                                      isFromBVisible = false;
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title:
                                    const Text("เมื่อทราบความยาวเส้นทแยงมุม"),
                                leading: Radio<SquareAreaFormula>(
                                  value: SquareAreaFormula.fromB,
                                  groupValue: _squareAreaFormula,
                                  onChanged: (SquareAreaFormula? value) {
                                    setState(() {
                                      _squareAreaFormula = value;
                                      isFromAVisible = false;
                                      isFromBVisible = true;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            children: [
                              Visibility(
                                  visible: isFromAVisible,
                                  child: Positioned(
                                      child: Column(
                                    children: [
                                      NumberField(
                                        labelText: "a",
                                        onChanged: calculate,
                                        controller: valueA,
                                      ),
                                    ],
                                  ))),
                              Visibility(
                                  visible: isFromBVisible,
                                  child: Positioned(
                                    child: Column(
                                      children: [
                                        NumberField(
                                          labelText: "b",
                                          onChanged: calculate,
                                          controller: valueB,
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: [
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}

class GraphicsVisual extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()
      ..color = Colors.blue
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    final recSize = size.width * 0.7;

    final rect = Rect.fromLTWH((size.width - recSize) / 2,
        (size.height - recSize) / 2, recSize, recSize);

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
