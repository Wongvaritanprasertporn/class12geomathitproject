import 'package:flutter/material.dart';
import 'package:geomath/numberField.dart';
import 'dart:math';

enum RhombusAreaFormula { fromAH, fromBC }

class RhombusCalcPage extends StatefulWidget {
  RhombusCalcPage({Key? key}) : super(key: key);

  @override
  _RhombusCalcPage createState() => _RhombusCalcPage();
}

class _RhombusCalcPage extends State<RhombusCalcPage> {
  var valueA = TextEditingController();
  var valueH = TextEditingController();
  var valueB = TextEditingController();
  var valueC = TextEditingController();

  num area = 0;
  num peri = 0;

  RhombusAreaFormula? _rhombusAreaFormula = RhombusAreaFormula.fromAH;
  bool showBottomMenu = true;
  final GlobalKey _widgetKey = GlobalKey();
  final GlobalKey _animatedPos = GlobalKey();
  Size? _size;

  var threshold = 100;

  bool isFromAhVisible = true;
  bool isFromBcVisible = false;

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    valueA.dispose();
    valueH.dispose();
    valueB.dispose();
    valueC.dispose();
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
      double b = 0;
      double h = double.tryParse(valueH.text) ?? 0;

      if (a != 0 && h != 0 && h < a) {
        setState(() {
          area = a * h;
          peri = 4 * a;
          b = sqrt(pow(a - sqrt(pow(a, 2) - pow(h, 2)), 2) + pow(h, 2));
          valueB.text = b.toString();
          valueC.text = (sqrt(pow(a, 2) - pow((b / 2), 2)) * 2).toString();
        });
      }
      else if (h >= a && a != 0) {
        valueH.text = valueH.text.substring(0, valueH.text.length - 1);
      }
      else if (a == 0 && h == 0){
        valueB.text = "";
        valueC.text = "";
      }
    }

    calculateFromBc(String string) {
      double a = 0;
      double b = double.tryParse(valueB.text) ?? 0;
      double c = double.tryParse(valueC.text) ?? 0;

      if (b != 0 && c != 0) {
        setState(() {
          area = 0.5 * b * c;
          a = sqrt(pow(b / 2, 2) + pow(c / 2, 2));
          peri = 4 * a;
          valueA.text = a.toString();
          valueH.text = (area / a).toString();
        });
      }
      else {
        valueA.text = "";
        valueH.text = "";
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
                h: double.tryParse(valueH.text) ?? 0,
                mode: _rhombusAreaFormula),
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
                child: Column(children: <Widget>[
                  Icon(
                    Icons.keyboard_arrow_up,
                    size: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(children: [
                      Column(
                        children: <Widget>[
                          ListTile(
                            title: const Text('เมื่อทราบความยาวด้านและความสูง'),
                            leading: Radio<RhombusAreaFormula>(
                              value: RhombusAreaFormula.fromAH,
                              groupValue: _rhombusAreaFormula,
                              onChanged: (RhombusAreaFormula? value) {
                                setState(() {
                                  _rhombusAreaFormula = value;
                                  isFromAhVisible = true;
                                  isFromBcVisible = false;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text(
                                'เมื่อทราบความยาวเส้นทแยงมุมทั้งสองเส้น'),
                            leading: Radio<RhombusAreaFormula>(
                              value: RhombusAreaFormula.fromBC,
                              groupValue: _rhombusAreaFormula,
                              onChanged: (RhombusAreaFormula? value) {
                                setState(() {
                                  _rhombusAreaFormula = value;
                                  isFromAhVisible = false;
                                  isFromBcVisible = true;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Stack(children: [
                        Visibility(
                          visible: isFromAhVisible,
                          child: Positioned(
                            child: Column(
                              children: [
                                NumberField(
                                  labelText: "a (ด้าน)",
                                  onChanged: calculateFromAh,
                                  controller: valueA,
                                ),
                                NumberField(
                                  labelText: "h (ความสูง)",
                                  onChanged: calculateFromAh,
                                  controller: valueH,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isFromBcVisible,
                          child: Positioned(
                            child: Column(
                              children: [
                                NumberField(
                                  labelText: "b",
                                  onChanged: calculateFromBc,
                                  controller: valueB,
                                ),
                                NumberField(
                                  labelText: "c",
                                  onChanged: calculateFromBc,
                                  controller: valueC,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: 10,),
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
                    ]),
                  ),
                ]),
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
  double h = 0;
  RhombusAreaFormula? mode;

  GraphicsVisual({required this.a, required this.h, required this.mode});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()
        ..color = Colors.black
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;

    a = double.parse(a.toStringAsFixed(4));
    h = double.parse(h.toStringAsFixed(4));

    double border = size.width * 0.1;

    double shift = sqrt(pow(a, 2) - pow(h, 2));
    double totalWidth = shift + a;
    double scaleForm = (size.width * 0.8) / totalWidth;

    double scaledShift = scaleForm * shift;
    double scaledA = scaleForm * a;
    double scaledH = scaleForm * h;
    double topBorder = (size.height - scaledH) / 2;

    Offset angleA = Offset(border + scaledShift, topBorder);
    Offset angleB = Offset(size.width * 0.9, topBorder);
    Offset angleC = Offset(border, topBorder + scaledH);
    Offset angleD = Offset(border + scaledA, topBorder + scaledH);
    Offset pointHB = Offset(border + scaledShift, topBorder + scaledH);

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

    final textC = TextPainter(
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
    textC.layout(minWidth: 0, maxWidth: 500);
    textH.layout(minWidth: 0, maxWidth: 500);

    Offset textPos = Offset(0, 0);

    if(a != 0 && h != 0) {
      canvas.drawLine(angleA, angleB, paint);
      canvas.drawLine(angleA, angleC, paint);
      canvas.drawLine(angleB, angleD, paint);
      canvas.drawLine(angleC, angleD, paint);

      canvas.save();
      double seta = asin(scaledH / scaledA);
      Offset halfOfA = Offset(border + (scaledShift / 2), (topBorder + scaledH) - (scaledH / 2));
      canvas.translate(border + (scaledShift / 2) , (size.height / 2) - textA.height);
      canvas.rotate(-seta);
      canvas.translate(-(textA.width / 2), -10);
      textA.paint(canvas, textPos);
      canvas.restore();

      // เส้นทแยงมุม
      if(mode == RhombusAreaFormula.fromBC) {
        canvas.drawLine(angleA, angleD, paint);
        canvas.drawLine(angleC, angleB, paint);
      }
      // สูง
      else if(mode == RhombusAreaFormula.fromAH) {
        canvas.drawLine(pointHB, angleA, paint);
        textH.paint(canvas, Offset(border + scaledShift - textH.width - 10,(size.height - textH.height) / 2));
      }

    }
  }

  @override
  bool shouldRepaint(covariant GraphicsVisual oldDelegate) {
    return oldDelegate.a != a || oldDelegate.h != h;
  }
}