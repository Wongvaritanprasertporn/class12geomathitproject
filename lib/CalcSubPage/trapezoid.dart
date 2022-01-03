import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geomath/numberField.dart';

class TrapezoidCalcPage extends StatefulWidget {
  TrapezoidCalcPage({Key? key}) : super(key: key);

  @override
  _TrapezoidCalcPage createState() => _TrapezoidCalcPage();
}

class _TrapezoidCalcPage extends State<TrapezoidCalcPage> {
  var valueA = TextEditingController();
  var valueB = TextEditingController();
  var valueH = TextEditingController();

  bool showBottomMenu = true;
  final GlobalKey _widgetKey = GlobalKey();
  final GlobalKey _animatedPos = GlobalKey();
  Size? _size;

  double area = 0;

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
      double h = double.tryParse(valueH.text) ?? 0;

      if (h < a && a < b) {
        setState(() {
          area = 0.5 * h * (a + b);
        });
      }
      else if (h >= a && a != 0){
        valueH.text = valueH.text.substring(0, valueH.text.length - 1);
      }
      else if(a >= b && b != 0) {
        valueA.text = valueA.text.substring(0, valueA.text.length - 1);
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
                h: double.tryParse(valueH.text) ?? 0,
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
                          Column(children: [
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
                            NumberField(
                              labelText: "h (ความสูง)",
                              onChanged: calculate,
                              controller: valueH,
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
                          ])
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
  double h = 0;
  GraphicsVisual({required this.a, required this.b, required this.h});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    a = double.parse(a.toStringAsFixed(4));
    b = double.parse(b.toStringAsFixed(4));
    h = double.parse(h.toStringAsFixed(4));

    final textA = TextPainter(
      text: TextSpan(
          text: "$a",
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold
          )
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    final textB = TextPainter(
      text: TextSpan(
          text: "$b",
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold
          )
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    final textH = TextPainter(
      text: TextSpan(
          text: "$h",
          style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold
          )
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    textA.layout(minWidth: 0, maxWidth: 500);
    textB.layout(minWidth: 0, maxWidth: 500);
    textH.layout(minWidth: 0, maxWidth: 500);

    double graphicAreaHeight = size.height * 0.8;
    double graphicAreaWidth = size.width * 0.8;

    double border = size.width * 0.1;

    double? scaleForm;
    if (b > h) {
      scaleForm = graphicAreaWidth / b;
    }
    else {
      scaleForm = graphicAreaHeight / h;
    }

    double scaledA = scaleForm * a;
    double scaledB = scaleForm * b;
    double scaledShift = scaledB - scaledA;
    double scaledH = scaleForm * h;

    double topBorder = (size.height - scaledH) / 2;

    Offset angleA = Offset(border + (scaledShift / 2), topBorder);
    Offset angleB = Offset(size.width - border - (scaledShift / 2), topBorder);
    Offset angleC = Offset(border, topBorder + scaledH);
    Offset angleD = Offset(size.width - border, topBorder + scaledH);
    Offset pointHB = Offset(border + (scaledShift / 2), topBorder + scaledH);

    if (a != 0 && b != 0 && h != 0) {
      canvas.drawLine(angleA, angleB, paint);
      canvas.drawLine(angleA, angleC, paint);
      canvas.drawLine(angleB, angleD, paint);
      canvas.drawLine(angleC, angleD, paint);
      canvas.drawLine(angleA, pointHB, paint);

      textA.paint(canvas, Offset((size.width - textA.width) / 2, topBorder - 30));
      textB.paint(canvas, Offset((size.width - textB.width) / 2, topBorder + scaledH + 10));
      textH.paint(canvas, Offset(border + (scaledShift / 2) + 10, (size.height - textH.height) / 2));

    }
  }

  @override
  bool shouldRepaint(covariant GraphicsVisual oldDelegate) {
    return oldDelegate.a != a || oldDelegate.b != b || oldDelegate.h != h;
  }
}