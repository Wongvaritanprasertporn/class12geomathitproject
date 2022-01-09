import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geomath/numberField.dart';

class RtriCalcPage extends StatefulWidget {
  RtriCalcPage({Key? key}) : super(key: key);

  @override
  _RtriCalcPage createState() => _RtriCalcPage();
}

class _RtriCalcPage extends State<RtriCalcPage> {
  var valueA = TextEditingController();
  var valueB = TextEditingController();

  bool showBottomMenu = true;
  final GlobalKey _widgetKey = GlobalKey();
  final GlobalKey _animatedPos = GlobalKey();
  Size? _size;

  double area = 0;
  double peri = 0;

  var threshold = 100;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => {_size = _widgetKey.currentContext?.size});
    double bottomConfig = (showBottomMenu) ? 0 : -(_size!.height - 30);

    calculate(String string) {
      double a = double.tryParse(valueA.text) ?? 0;
      double b = double.tryParse(valueB.text) ?? 0;

      setState(() {
        area = 0.5 * a * b;
        peri = a + b + sqrt(pow(a, 2) + pow(b, 2));
      });
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
                      child: Column(
                        children: [
                          NumberField(
                            labelText: "a",
                            onChanged: calculate,
                            controller: valueA,
                          ),
                          NumberField(
                            labelText: "b",
                            onChanged: calculate,
                            controller: valueB,
                          ),
                          SizedBox(height: 10),
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
                          ),
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

class GraphicsVisual extends CustomPainter {
  double a = 0;
  double b = 0;
  GraphicsVisual({required this.a, required this.b});

  @override
  void paint(Canvas canvas, Size size) {
    double c = sqrt(pow(a, 2) + pow(b, 2));

    final paint = new Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    a = double.parse(a.toStringAsFixed(4));
    b = double.parse(b.toStringAsFixed(4));
    c = double.parse(c.toStringAsFixed(4));

    double graphicAreaHeight = size.height * 0.8;
    double graphicAreaWidth = size.width * 0.8;

    double leftBorder = size.width * 0.1;
    double topBorder = size.height * 0.1;

    double scaleForm = 0;
    if (a / b <= graphicAreaWidth / graphicAreaHeight) {
      scaleForm = graphicAreaHeight / b;
      leftBorder = (size.width - (scaleForm * a)) / 2;
    } else {
      scaleForm = graphicAreaWidth / a;
      topBorder = ((size.height - (scaleForm * b)) / 2);
    }

    double scaledA = scaleForm * a;
    double scaledB = scaleForm * b;

    Offset angleA = Offset(leftBorder, topBorder);
    Offset angleB = Offset(leftBorder, topBorder + scaledB);
    Offset angleC = Offset(size.width - leftBorder, topBorder + scaledB);

    final textA = TextPainter(
      text: TextSpan(
          text: "$a",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    final textB = TextPainter(
      text: TextSpan(
          text: "$b",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    final textC = TextPainter(
      text: TextSpan(
          text: "$c",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    textA.layout(minWidth: 0, maxWidth: 500);
    textB.layout(minWidth: 0, maxWidth: 500);
    textC.layout(minWidth: 0, maxWidth: 500);

    if (a != 0 && b != 0) {
      canvas.drawLine(angleA, angleB, paint);
      canvas.drawLine(angleB, angleC, paint);
      canvas.drawLine(angleC, angleA, paint);

      textA.paint(canvas,
          Offset((size.width - textA.width) / 2, topBorder + scaledB + 10));

      canvas.save();
      canvas.translate(leftBorder, size.height / 2);
      canvas.rotate(-pi / 2);
      canvas.translate(-textB.width / 2, -textB.height - 10);
      textB.paint(canvas, Offset(0, 0));
      canvas.restore();

      canvas.save();
      canvas.translate(leftBorder + scaledA / 2, size.height / 2);
      canvas.rotate(atan(b / a));
      canvas.translate(-textC.width / 2, -textC.height - 10);
      textC.paint(canvas, Offset(0, 0));
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant GraphicsVisual oldDelegate) {
    return oldDelegate.a != a || oldDelegate.b != b;
  }
}
