import 'package:flutter/material.dart';
import 'package:geomath/numberField.dart';
import 'dart:math';

class CircleCalcPage extends StatefulWidget {
  CircleCalcPage({Key? key}) : super(key: key);

  @override
  _CircleCalcPage createState() => _CircleCalcPage();
}

class _CircleCalcPage extends State<CircleCalcPage> {
  var valueR = TextEditingController();

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
      double r = double.tryParse(valueR.text) ?? 0;

      setState(() {
        area = pi * pow(r, 2);
        peri = 2 * pi * r;
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
              r: double.tryParse(valueR.text) ?? 0,
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
                          Column(
                            children: [
                              NumberField(
                                  labelText: "r (รัศมี)",
                                  onChanged: calculate,
                                  controller: valueR),
                            ],
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
                          )
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
  double r = 0;
  GraphicsVisual({required this.r});

  @override
  void paint(Canvas canvas, Size size) {
    double diameter = r * 2;

    final paint = new Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final textR = TextPainter(
      text: TextSpan(
          text: "$r",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    final textDiameter = TextPainter(
      text: TextSpan(
          text: "\u2300 = $diameter",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    textR.layout(minWidth: 0, maxWidth: 500);
    textDiameter.layout(minWidth: 0, maxWidth: 500);

    if (r != 0) {
      canvas.drawCircle(Offset(size.width / 2, size.height / 2),
          (size.width * 0.8) / 2, paint);
      canvas.drawLine(Offset(size.width / 2, size.height / 2),
          Offset(size.width * 0.9, size.height / 2), paint);

      textR.paint(
          canvas,
          Offset(size.width * 0.7 - textR.width / 2,
              (size.height / 2) - textR.height - 10));

      textDiameter.paint(
          canvas,
          Offset((size.width - textDiameter.width) / 2,
              (size.height / 2) - (size.width * 0.2) - textDiameter.height));
    }
  }

  @override
  bool shouldRepaint(covariant GraphicsVisual oldDelegate) {
    return oldDelegate.r != r;
  }
}
