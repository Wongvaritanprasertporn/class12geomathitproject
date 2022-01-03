import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geomath/numberField.dart';

class RectangleCalcPage extends StatefulWidget {
  RectangleCalcPage({Key? key}) : super(key: key);

  @override
  _RectangleCalcPage createState() => _RectangleCalcPage();
}

class _RectangleCalcPage extends State<RectangleCalcPage> {
  bool showBottomMenu = true;

  var valueA = TextEditingController();
  var valueB = TextEditingController();

  double area = 0;
  double peri = 0;

  final GlobalKey _widgetKey = GlobalKey();
  final GlobalKey _animatedPos = GlobalKey();

  Size? _size;

  var threshold = 100;

  @override
  void initState() {
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
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => {_size = _widgetKey.currentContext?.size});
    double bottomConfig = (showBottomMenu) ? 0 : -(_size!.height - 30);

    void calculate(String string) {
      double a = double.tryParse(valueA.text) ?? 0;
      double b = double.tryParse(valueB.text) ?? 0;
      setState(() {
        area = a * b;
        peri = 2 * (a + b);
      });
    }

    return Stack(children: [
      Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: CustomPaint(
          painter: GraphicsVisual(
              a: double.tryParse(valueA.text) ?? 0,
              b: double.tryParse(valueB.text) ?? 0),
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
              border: Border.all(
                color: Colors.black38,
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
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
                            Column(
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
                          ],
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
    ]);
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

    final border = size.width * 0.8;
    final rectHeight1 = (a / b) * border;
    final rectWidth2 = (b / a) * border;

    var rect;

    if (rectHeight1 < size.height * 0.8) {
      rect = Rect.fromLTWH((size.width - border) / 2,
          (size.height - rectHeight1) / 2, border, rectHeight1);
    } else {
      rect = Rect.fromLTWH((size.width - rectWidth2) / 2,
          (size.height - border) / 2, rectWidth2, border);
    }

    final textA = TextPainter(
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

    final textB = TextPainter(
        text: TextSpan(
          text: "$b",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);

    textA.layout(minWidth: 0, maxWidth: 1000);
    textB.layout(minWidth: 0, maxWidth: 1000);

    Offset aDrawPos = Offset(0, 0);

    Offset bDrawPos = Offset(0, 0);

    if (rectHeight1 < size.height * 0.8) {
      aDrawPos = Offset(
          (size.height - textA.width) / 2, (size.width - border) / 2 - 30);
      bDrawPos = Offset(
          (size.width - textB.width) / 2, (size.height - rectHeight1) / 2 - 30);
    } else {
      aDrawPos = Offset(
          (size.height - textA.width) / 2, (size.width - rectWidth2) / 2 - 30);
      bDrawPos = Offset(
          (size.width - textB.width) / 2, (size.height - border) / 2 - 30);
    }

    if (a != 0 && b != 0) {
      canvas.drawRect(rect, paint);
      textB.paint(canvas, bDrawPos);

      canvas.save();
      canvas.rotate(-0.5 * pi);
      canvas.translate(-(aDrawPos.dx * 2 + textA.width), 0);
      textA.paint(canvas, aDrawPos);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant GraphicsVisual oldDelegate) {
    return oldDelegate.a != a || oldDelegate.b != b;
  }
}
