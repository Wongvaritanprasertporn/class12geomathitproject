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
  double interAH = 0;

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

      if (a != 0 && b != 0 && c != 0) {
        if (b >= a) {
          setState(() {
            b = a - 1;
            valueB.text = b.toString();
          });
        }
        if (c >= a) {
          setState(() {
            c = a - 1;
            valueC.text = c.toString();
          });
        }
        if (b + c <= a) {
          setState(() {
            c = a - b + 1;
            valueC.text = c.toString();
          });
        }
        double s = 0.5 * (a + b + c);
        double h = (sqrt(s * (s - a) * (s - b) * (s - c)) * 2) / a;
        setState(() {
          area = sqrt(s * (s - a) * (s - b) * (s - c));
          peri = a + b + c;
          interAH = sqrt(pow(b, 2) - pow(h, 2));
          valueH.text = h.toString();
        });
      } else {
        setState(() {
          area = 0;
          peri = a + b + c;
          valueH.text = "";
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
                h: double.tryParse(valueH.text) ?? 0,
                interAH: interAH,
                mode: _triangleAreaFormula),
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

class GraphicsVisual extends CustomPainter {
  double a = 0;
  double b = 0;
  double c = 0;
  double h = 0;
  double interAH;
  TriangleAreaFormula? mode;
  GraphicsVisual(
      {required this.a,
      required this.b,
      required this.c,
      required this.h,
      required this.interAH,
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
    h = double.parse(h.toStringAsFixed(4));

    double graphicAreaHeight = size.height * 0.8;
    double graphicAreaWidth = size.width * 0.8;

    double scaleForm = 0;
    double leftBorder = size.width * 0.1;
    double topBorder = size.height * 0.1;

    if (mode == TriangleAreaFormula.fromAH && a != 0 && h != 0) {
      double scaleForm = 0;
      if (a / h <= graphicAreaWidth / graphicAreaHeight) {
        scaleForm = graphicAreaHeight / h;
        leftBorder = (size.width - (scaleForm * a)) / 2;
      } else {
        scaleForm = graphicAreaWidth / a;
        topBorder = (size.height - (scaleForm * h)) / 2;
      }

      double scaledA = scaleForm * a;
      double scaledH = scaleForm * h;

      Offset angleA = Offset(size.width / 2, topBorder);
      Offset angleB = Offset(leftBorder, size.height - topBorder);
      Offset angleC = Offset(size.width - leftBorder, size.height - topBorder);
      Offset interAH = Offset(size.width / 2, size.height - topBorder);

      canvas.drawLine(angleA, angleB, paint);
      canvas.drawLine(angleB, angleC, paint);
      canvas.drawLine(angleC, angleA, paint);
      canvas.drawLine(angleA, interAH, paint);
    } else if (mode == TriangleAreaFormula.fromSide &&
        a != 0 &&
        b != 0 &&
        c != 0 &&
        h != 0 &&
        interAH != 0) {
      double scaleForm = 0;
      if (a / h <= graphicAreaWidth / graphicAreaHeight) {
        scaleForm = graphicAreaHeight / h;
        leftBorder = (size.width - (scaleForm * a)) / 2;
      } else {
        scaleForm = graphicAreaWidth / a;
        topBorder = (size.height - (scaleForm * h)) / 2;
      }

      double scaledA = scaleForm * a;
      double scaledB = scaleForm * b;
      double scaledC = scaleForm * c;
      double scaledH = scaleForm * h;
      double scaledInterAH = scaleForm * interAH;

      Offset angleA = Offset(leftBorder + scaledInterAH, topBorder);
      Offset angleB = Offset(leftBorder, topBorder + scaledH);
      Offset angleC = Offset(size.width - leftBorder, topBorder + scaledH);

      final textA = TextPainter(
        text: TextSpan(
            text: "$a",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );

      final textB = TextPainter(
        text: TextSpan(
            text: "$b",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );

      final textC = TextPainter(
        text: TextSpan(
            text: "$c",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );

      textA.layout(minWidth: 0, maxWidth: 500);
      textB.layout(minWidth: 0, maxWidth: 500);
      textC.layout(minWidth: 0, maxWidth: 500);

      canvas.drawLine(angleA, angleB, paint);
      canvas.drawLine(angleB, angleC, paint);
      canvas.drawLine(angleC, angleA, paint);

      textA.paint(canvas,
          Offset((size.width - textA.width) / 2, topBorder + scaledH + 10));

      canvas.save();
      canvas.translate(
          leftBorder + (scaledInterAH / 2), topBorder + scaledH / 2);
      canvas.rotate(-asin(h / b));
      canvas.translate(-textB.width / 2, -textB.height - 10);
      textB.paint(canvas, Offset(0, 0));
      canvas.restore();

      canvas.save();
      canvas.translate(
          leftBorder + scaledInterAH + (scaledA - scaledInterAH) / 2,
          topBorder + scaledH / 2);
      canvas.rotate(asin(h / c));
      canvas.translate(-textC.width / 2, -textC.height - 10);
      textC.paint(canvas, Offset(0, 0));
      canvas.restore();
    }

    final textH = TextPainter(
      text: TextSpan(
          text: "$h",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    textH.layout(minWidth: 0, maxWidth: 500);
  }

  @override
  bool shouldRepaint(covariant GraphicsVisual oldDelegate) {
    return oldDelegate.a != a ||
        oldDelegate.b != b ||
        oldDelegate.c != c ||
        oldDelegate.h != h ||
        oldDelegate.interAH != interAH;
  }
}
