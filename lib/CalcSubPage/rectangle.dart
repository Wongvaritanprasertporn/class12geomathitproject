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
          painter: GraphicsVisual(double.tryParse(valueA.text) ?? 0,
              double.tryParse(valueB.text) ?? 0),
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
  GraphicsVisual(a, b);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()
      ..color = Colors.blue
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    final rect =
        Rect.fromLTWH(10, 10, size.width * 0.7, (a / b) * (size.width * 0.7));

    if (a != 0 && b != 0) {
      canvas.drawRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
