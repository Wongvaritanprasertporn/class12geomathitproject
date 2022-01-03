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

  var valueA = TextEditingController();
  var valueB = TextEditingController();

  num area = 0.0;
  num peri = 0.0;

  Size? _size;
  var threshold = 100;

  bool showBottomMenu = true;
  final GlobalKey _widgetKey = GlobalKey();
  final GlobalKey _animatedPos = GlobalKey();

  bool isFromAVisible = true;
  bool isFromBVisible = false;

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    valueA.dispose();
    valueB.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double bottomConfig = (showBottomMenu) ? 0 : -(_size!.height - 30);
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => {_size = _widgetKey.currentContext?.size});

    calculateFromA(String string) {
      var gettedNumber = double.tryParse(string) ?? 0;
      setState(() {
        area = pow(gettedNumber, 2);
        peri = gettedNumber * 4;
        valueB.text = sqrt(pow(gettedNumber, 2) * 2).toString();
      });
    }

    calculateFromB(String string) {
      var gettedNumber = double.tryParse(string) ?? 0;
      setState(() {
        area = 0.5 * pow(gettedNumber, 2);
        peri = sqrt(0.5 * pow(gettedNumber, 2)) * 4;
        valueA.text = sqrt(pow(gettedNumber, 2) / 2).toString();
      });
    }

    return Container(
      child: Stack(children: [
        Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: CustomPaint(
            painter: GraphicsVisual(a: double.tryParse(valueA.text) ?? 0),
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
              } else if (details.velocity.pixelsPerSecond.dy < -threshold) {
                this.setState(() {
                  showBottomMenu = true;
                });
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
                                    child: NumberField(
                                      labelText: "a",
                                      onChanged: calculateFromA,
                                      controller: valueA,
                                    ),
                                  )),
                              Visibility(
                                  visible: isFromBVisible,
                                  child: Positioned(
                                    child: NumberField(
                                      labelText: "b",
                                      onChanged: calculateFromB,
                                      controller: valueB,
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
  double a = 0;
  GraphicsVisual({required this.a});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    a = double.parse(a.toStringAsFixed(4));

    final recSize = size.width * 0.8;

    final textPainter = TextPainter(
        text: TextSpan(
          text: "$a",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    textPainter.layout(minWidth: 0, maxWidth: 1000);
    Offset drawPosition = Offset(
        (size.width - textPainter.width) / 2, (size.height - recSize) / 2 - 30);

    textPainter.paint(canvas, drawPosition);

    final rect = Rect.fromLTWH((size.width - recSize) / 2,
        (size.height - recSize) / 2, recSize, recSize);

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(GraphicsVisual oldDelegate) {
    return oldDelegate.a != a;
  }
}
