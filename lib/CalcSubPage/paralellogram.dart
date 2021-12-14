import 'package:flutter/material.dart';
import 'package:geomath/numberField.dart';

class ParaCalcPage extends StatefulWidget {
  ParaCalcPage({Key? key}) : super(key: key);

  @override
  _ParaCalcPage createState() => _ParaCalcPage();
}

class _ParaCalcPage extends State<ParaCalcPage> {
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

    calculate(String string) {
      double a = double.tryParse(valueA.text) ?? 0;
      double b = double.tryParse(valueB.text) ?? 0;
      double h = double.tryParse(valueH.text) ?? 0;

      if (a != 0 && b != 0 && h != 0) {
        setState(() {
          area = b * h;
          peri = 2 * (a + b);
        });
      } else {
        area = 0;
        peri = 0;
      }
    }

    return Container(
      child: Stack(children: [
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
                          Padding(
                              padding: const EdgeInsets.only(top: 10.0),
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
                                  NumberField(
                                    labelText: "h",
                                    onChanged: calculate,
                                    controller: valueH,
                                  ),
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
                              )),
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
