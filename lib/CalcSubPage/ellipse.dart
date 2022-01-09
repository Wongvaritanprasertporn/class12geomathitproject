import 'package:flutter/material.dart';
import 'package:geomath/numberField.dart';
import 'dart:math';

class EllipseCalcPage extends StatefulWidget {
  EllipseCalcPage({Key? key}) : super(key: key);

  @override
  _EllipseCalcPage createState() => _EllipseCalcPage();
}

class _EllipseCalcPage extends State<EllipseCalcPage> {
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

      if (a != 0 && b != 0) {
        setState(() {
          area = (pi * a * b) / 4;
          peri = (pi * (a + b)) / 2;
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
                            labelText: "a (รัศมีแนวยาว)",
                            onChanged: calculate,
                            controller: valueA,
                          ),
                          NumberField(
                            labelText: "b (รัศมีแนวสั้น)",
                            onChanged: calculate,
                            controller: valueB,
                          ),
                          SizedBox(
                            height: 10,
                          ),
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
                        ],
                      ),
                    )
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
    final paint = new Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    a = double.parse(a.toStringAsFixed(4));
    b = double.parse(b.toStringAsFixed(4));

    double graphicAreaHeight = size.height * 0.8;
    double graphicAreaWidth = size.width * 0.8;

    double scaleForm = 0;
    double leftBorder = size.width * 0.1;
    double topBorder = size.height * 0.1;

    if (a / b <= graphicAreaWidth / graphicAreaHeight) {
      scaleForm = graphicAreaHeight / b;
      leftBorder = (size.width - (scaleForm * a)) / 2;
    } else {
      scaleForm = graphicAreaWidth / a;
      topBorder = (size.height - (scaleForm * b)) / 2;
    }

    double scaledA = scaleForm * a;
    double scaledB = scaleForm * b;

    final rect = Rect.fromLTWH(leftBorder, topBorder, scaledA, scaledB);
    final pointA = Offset(size.width / 2, topBorder);
    final pointB = Offset(leftBorder, size.height / 2);
    final pointC = Offset(leftBorder + scaledA, size.height / 2);
    final pointD = Offset(size.width / 2, topBorder + scaledB);

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
      canvas.drawOval(rect, paint);
      canvas.drawLine(pointA, pointD, paint);
      canvas.drawLine(pointB, pointC, paint);

      textA.paint(
          canvas,
          Offset(leftBorder + scaledA / 4 - textA.width / 2,
              topBorder + scaledB / 2 - textA.height - 10));

      textB.paint(
          canvas,
          Offset(leftBorder + scaledA / 2 + 10,
              topBorder + (3 / 4 * scaledB) - (textB.height / 2)));
    }
  }

  @override
  bool shouldRepaint(covariant GraphicsVisual oldDelegate) {
    return oldDelegate.a != a || oldDelegate.b != b;
  }
}
