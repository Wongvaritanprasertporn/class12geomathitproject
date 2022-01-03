import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geomath/numberField.dart';

enum ParalellogramAreaFormula { area, peri }

class ParaCalcPage extends StatefulWidget {
  ParaCalcPage({Key? key}) : super(key: key);

  @override
  _ParaCalcPage createState() => _ParaCalcPage();
}

class _ParaCalcPage extends State<ParaCalcPage> {
  ParalellogramAreaFormula? _paralellogramAreaFormula =
      ParalellogramAreaFormula.area;

  var valueA = TextEditingController();
  var valueB = TextEditingController();
  var valueH = TextEditingController();

  bool showBottomMenu = true;
  final GlobalKey _widgetKey = GlobalKey();
  final GlobalKey _animatedPos = GlobalKey();
  Size? _size;

  bool isFromAreaVisible = true;
  bool isFromPeriVisible = false;

  num area = 0;
  num peri = 0;

  var threshold = 100;

  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    valueA.dispose();
    valueB.dispose();
    valueH.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => {_size = _widgetKey.currentContext?.size});
    double bottomConfig = (showBottomMenu) ? 0 : -(_size!.height - 30);

    calculateArea(String string) {
      double b = double.tryParse(valueB.text) ?? 0;
      double h = double.tryParse(valueH.text) ?? 0;
      double a = sqrt(pow(((3 * b) / 4), 2) + pow(h, 2));

      if (b != 0 && h != 0) {
        setState(() {
          area = b * h;
          peri = 2 * (a + b);
        });
      }
      else {
        setState(() {
          area = 0;
          peri = 0;
        });
      }
    }

    calculatePeri(String string) {
      double a = double.tryParse(valueA.text) ?? 0;
      double b = double.tryParse(valueB.text) ?? 0;

      if (a != 0 && b != 0) {
        setState(() {
          peri = 2 * (a + b);
        });
      }
      else {
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
                h: double.tryParse(valueH.text) ?? 0,
                mode: _paralellogramAreaFormula),
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
                        children: [
                          ListTile(
                            title: const Text("หาพื้นที่"),
                            leading: Radio<ParalellogramAreaFormula>(
                              value: ParalellogramAreaFormula.area,
                              groupValue: _paralellogramAreaFormula,
                              onChanged: (ParalellogramAreaFormula? value) {
                                setState(() {
                                  valueA.text = "";
                                  area = 0;
                                  peri = 0;
                                  _paralellogramAreaFormula = value;
                                  isFromAreaVisible = true;
                                  isFromPeriVisible = false;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: const Text("หาความยาวเส้นรอบรูป"),
                            leading: Radio<ParalellogramAreaFormula>(
                              value: ParalellogramAreaFormula.peri,
                              groupValue: _paralellogramAreaFormula,
                              onChanged: (ParalellogramAreaFormula? value) {
                                setState(() {
                                  valueH.text = "";
                                  area = 0;
                                  peri = 0;
                                  _paralellogramAreaFormula = value;
                                  isFromAreaVisible = false;
                                  isFromPeriVisible = true;
                                });
                              },
                            ),
                          ),
                          Stack(
                            children: [
                              Visibility(
                                  visible: isFromAreaVisible,
                                  child: Positioned(
                                      child: Column(
                                    children: [
                                      NumberField(
                                        labelText: "b",
                                        onChanged: calculateArea,
                                        controller: valueB,
                                      ),
                                      NumberField(
                                        labelText: "h",
                                        onChanged: calculateArea,
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
                                  ))),
                              Visibility(
                                  visible: isFromPeriVisible,
                                  child: Column(
                                    children: [
                                      NumberField(
                                        labelText: "a",
                                        onChanged: calculatePeri,
                                        controller: valueA,
                                      ),
                                      NumberField(
                                        labelText: "b",
                                        onChanged: calculatePeri,
                                        controller: valueB,
                                      ),
                                      SizedBox(
                                        height: 10,
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
                                  ))
                            ],
                          ),
                        ],
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
  double b = 0;
  double h = 0;
  ParalellogramAreaFormula? mode;
  GraphicsVisual(
      {required this.a, required this.b, required this.h, required this.mode});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = new Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // หาความยาวและความกว้างของรูป
    b = double.parse(b.toStringAsFixed(4));
    if (mode == ParalellogramAreaFormula.area) {
      a = double.parse(sqrt(pow(((3 * b) / 4), 2) + pow(h, 2)).toStringAsFixed(4));
    } else if (mode == ParalellogramAreaFormula.peri) {
      h = double.parse(((2 * a) / 3).toStringAsFixed(4));
    }
    double shift = sqrt(pow(a, 2) - pow(h, 2));
    double totalWidth = b + shift;
    double graphicAreaHeight = size.height * 0.8;
    double graphicAreaWidth = size.width * 0.8;

    //กำหนดอัตราส่วน

    double scaleForm = 0;

    // เมื่อรูปสูงกว่าความกว้าง
    if (totalWidth / h <= graphicAreaWidth / graphicAreaHeight) {
      scaleForm = graphicAreaHeight / h;
    }
    //เมื่อรูปกว้างกว่าความสูง
    else {
      scaleForm = graphicAreaWidth / totalWidth;
    }

    // กำหนดพิกัดให้กับเส้น

    double scaledA = scaleForm * a;
    double scaledB = scaleForm * b;
    double scaledH = scaleForm * h;
    double scaledTotalWidth = scaleForm * totalWidth;
    double scaledShift = scaleForm * shift;
    double leftBorder = size.width * 0.1;
    double topBorder = size.height * 0.1;
    double leftBorderBySize = (size.width - scaledTotalWidth) / 2;
    double topBorderBySize = (size.height - scaledH) / 2;

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

    final textH = TextPainter(
        text: TextSpan(
          text: "$h",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    textA.layout(minWidth: 0, maxWidth: 500);
    textB.layout(minWidth: 0, maxWidth: 500);
    textH.layout(minWidth: 0, maxWidth: 500);

    Offset? angleA;
    Offset? angleB;
    Offset? angleC;
    Offset? angleD;
    Offset? pointHB;
    Offset? textAPos = Offset(0, 0);
    Offset? textBPos;
    Offset? textHPos;

    if (scaledTotalWidth / scaledH <= graphicAreaWidth / graphicAreaHeight) {
      angleA = Offset(leftBorderBySize + scaledShift, topBorder);
      angleB = Offset(size.width - leftBorderBySize, topBorder);
      angleC = Offset(leftBorderBySize, size.height - topBorder);
      angleD = Offset(size.width - leftBorderBySize - scaledShift, size.height - topBorder);
      pointHB = Offset(leftBorderBySize + scaledShift, size.height - topBorder);
      textBPos =
          Offset(size.width / 2, (size.height - graphicAreaHeight) / 2 - 30);
      textHPos = Offset(leftBorderBySize + scaledShift + 10,
          (size.height - textH.height) / 2);
    } else {
      angleA = Offset(leftBorder + scaledShift,
          topBorderBySize);
      angleB = Offset(leftBorder + scaledTotalWidth,
          topBorderBySize);
      angleC = Offset(leftBorder,
          topBorderBySize + scaledH);
      angleD = Offset(leftBorder + scaledB,
          topBorderBySize + scaledH);
      pointHB = Offset(leftBorder + scaledShift,
          topBorderBySize + scaledH);
      textBPos = Offset(leftBorder + scaledShift + ((scaledB - textB.width) / 2), topBorderBySize - 30);
      textHPos = Offset(leftBorder + scaledShift - (textH.width) - 10,
          size.height / 2 - (textB.height / 2));
    }

    if ((mode == ParalellogramAreaFormula.area && b != 0 && h != 0) || (mode == ParalellogramAreaFormula.peri && a != 0 && b != 0)) {
      // เส้น b ด้านบน
      canvas.drawLine(angleA, angleB, paint);
      // เส้น a ด้านซ้าย
      canvas.drawLine(angleA, angleC, paint);
      // เส้น a ด้านขวา
      canvas.drawLine(angleB, angleD, paint);
      // เส้น b ด้านล่าง
      canvas.drawLine(angleC, angleD, paint);
      // text b
      textB.paint(canvas, textBPos);

      //เส้น h
      if (mode == ParalellogramAreaFormula.area) {
        canvas.drawLine(angleA, pointHB, paint);
        // text h
        textH.paint(canvas, textHPos);
      }
      else if(mode == ParalellogramAreaFormula.peri) {
        // text a
        canvas.save();
        double seta = asin(scaledH / scaledA);
        if (totalWidth <= h) {
          canvas.translate(leftBorder + (scaledShift / 2), (size.height - graphicAreaHeight) / 2 + (scaledH / 2));
        }
        else {
          canvas.translate(leftBorder + (scaledShift / 2), topBorder + (scaledH / 2) - textA.height);
        }
        canvas.rotate(-seta);
        canvas.translate(-(textH.width / 2), -10);

        textA.paint(canvas, textAPos);
        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(covariant GraphicsVisual oldDelegate) {
    return oldDelegate.a != a || oldDelegate.b != b || oldDelegate.h != h || oldDelegate.mode != mode;
  }
}
