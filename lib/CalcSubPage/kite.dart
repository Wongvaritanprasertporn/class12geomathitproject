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
        });
      } else {
        setState(() {
          area = 0;
        });
      }
    }

    calculateFromAb(String string) {
      double a = double.tryParse(valueA.text) ?? 0;
      double b = double.tryParse(valueB.text) ?? 0;

      if (a != 0 && b != 0) {
        if (a >= b) {
          setState(() {
            a = b - 1;
            valueA.text = a.toString();
          });
        }
        setState(() {
          peri = 2 * (a + b);
        });
      } else {
        setState(() {
          peri = 0;
        });
      }
    }

    return Container(
      child: Stack(children: [
        Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: CustomPaint(
            painter: GraphicsVisual(
              a: double.tryParse(valueA.text) ?? 0,
              b: double.tryParse(valueB.text) ?? 0,
              c: double.tryParse(valueC.text) ?? 0,
              d: double.tryParse(valueD.text) ?? 0,
              mode: _kiteAreaFormula,
            ),
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

class GraphicsVisual extends CustomPainter {
  double a = 0;
  double b = 0;
  double c = 0;
  double d = 0;
  KiteAreaFormula? mode;
  GraphicsVisual(
      {required this.a,
      required this.b,
      required this.c,
      required this.d,
      required this.mode});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    a = double.parse(a.toStringAsFixed(4));
    b = double.parse(b.toStringAsFixed(4));
    c = double.parse(c.toStringAsFixed(4));
    d = double.parse(d.toStringAsFixed(4));

    double leftBorder = size.width * 0.1;
    double topBorder = size.height * 0.1;

    double graphicAreaHeight = size.height * 0.8;
    double graphicAreaWidth = size.width * 0.8;

    if (mode == KiteAreaFormula.fromCD) {
      double scaleForm = 0;
      if (d / c <= graphicAreaWidth / graphicAreaHeight) {
        scaleForm = graphicAreaHeight / c;
        leftBorder = (size.width - (scaleForm * d)) / 2;
      } else {
        scaleForm = graphicAreaWidth / d;
        topBorder = (size.height - (scaleForm * c)) / 2;
      }
      double scaledC = scaleForm * c;
      double scaledD = scaleForm * d;
      double interCD = (1 / 3) * scaledC;

      Offset angleA = Offset(size.width / 2, topBorder);
      Offset angleB = Offset(leftBorder, topBorder + interCD);
      Offset angleC = Offset(size.width - leftBorder, topBorder + interCD);
      Offset angleD = Offset(size.width / 2, size.height - topBorder);

      final textC = TextPainter(
          text: TextSpan(
              text: "$c",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center);

      final textD = TextPainter(
          text: TextSpan(
              text: "$d",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center);

      textC.layout(minWidth: 0, maxWidth: 500);
      textD.layout(minWidth: 0, maxWidth: 500);

      if (c != 0 && d != 0) {
        canvas.drawLine(angleA, angleB, paint);
        canvas.drawLine(angleB, angleD, paint);
        canvas.drawLine(angleC, angleD, paint);
        canvas.drawLine(angleC, angleA, paint);
        canvas.drawLine(angleA, angleD, paint);
        canvas.drawLine(angleB, angleC, paint);

        canvas.save();
        canvas.translate(
            size.width / 2, topBorder + interCD + (scaledC - interCD) / 2);
        canvas.rotate(-pi / 2);
        canvas.translate(textC.width / 2, -textC.height - 10);
        textC.paint(canvas, Offset(0, 0));
        canvas.restore();

        textD.paint(
            canvas,
            Offset(leftBorder + (scaledD - textD.width) / 4,
                topBorder + interCD - textD.height - 10));
      }
    } else {
      double resultD = cos(pi / 6) * a * 2;
      double resultC = cos(pi / 3) * a + sqrt(pow(b, 2) - pow(resultD / 2, 2));

      double scaleForm = 0;
      if (resultD / resultC <= graphicAreaWidth / graphicAreaHeight) {
        scaleForm = graphicAreaHeight / resultC;
        leftBorder = (size.width - (scaleForm * resultD)) / 2;
      } else {
        scaleForm = graphicAreaWidth / resultD;
        topBorder = (size.height - (scaleForm * resultC)) / 2;
      }

      double scaledA = scaleForm * a;
      double scaledC = scaleForm * resultC;
      double scaledD = scaleForm * resultD;

      double interCD = cos(pi / 3) * scaledA;

      Offset angleA = Offset(size.width / 2, topBorder);
      Offset angleB = Offset(leftBorder, topBorder + interCD);
      Offset angleC = Offset(size.width - leftBorder, topBorder + interCD);
      Offset angleD = Offset(size.width / 2, size.height - topBorder);

      final textA = TextPainter(
          text: TextSpan(
              text: "$a",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center);

      final textB = TextPainter(
          text: TextSpan(
              text: "$b",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center);

      textA.layout(minWidth: 0, maxWidth: 500);
      textB.layout(minWidth: 0, maxWidth: 500);

      if (a != 0 && b != 0) {
        canvas.drawLine(angleA, angleB, paint);
        canvas.drawLine(angleB, angleD, paint);
        canvas.drawLine(angleC, angleD, paint);
        canvas.drawLine(angleC, angleA, paint);
        canvas.drawLine(angleA, angleD, paint);
        canvas.drawLine(angleB, angleC, paint);

        canvas.save();
        canvas.translate(leftBorder + (scaledD / 4), topBorder + interCD / 2);
        canvas.rotate(-acos((resultD / 2) / a));
        canvas.translate(-textA.width / 2, -textA.height - 10);
        textA.paint(canvas, Offset(0, 0));
        canvas.restore();

        canvas.save();
        canvas.translate(leftBorder + (scaledD / 4),
            topBorder + interCD + (scaledC - interCD) / 2);
        canvas.rotate(acos((resultD / 2) / b));
        canvas.translate(-textB.width / 2, 10);
        textB.paint(canvas, Offset(0, 0));
        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(covariant GraphicsVisual oldDelegate) {
    return oldDelegate.a != a ||
        oldDelegate.b != b ||
        oldDelegate.c != c ||
        oldDelegate.d != d ||
        oldDelegate.mode != mode;
  }
}
