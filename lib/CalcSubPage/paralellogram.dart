import 'package:flutter/material.dart';
import 'package:geomath/numberField.dart';

enum ParalellogramFormula { area, peri }

class ParaCalcPage extends StatefulWidget {
  ParaCalcPage({Key? key}) : super(key: key);

  @override
  _ParaCalcPage createState() => _ParaCalcPage();
}

class _ParaCalcPage extends State<ParaCalcPage> {
  ParalellogramFormula? _paralellogramFormula = ParalellogramFormula.area;

  bool showBottomMenu = true;
  final GlobalKey _widgetKey = GlobalKey();
  final GlobalKey _animatedPos = GlobalKey();
  Size? _size;

  var threshold = 100;

  getData() {
    switch (_paralellogramFormula) {
      case ParalellogramFormula.area:
        return CalcPageArea();
      case ParalellogramFormula.peri:
        return CalcPagePeri();
      default:
        print("Something went wrong.");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => {_size = _widgetKey.currentContext?.size});
    double bottomConfig = (showBottomMenu) ? 0 : -(_size!.height - 30);

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
                        child: Column(
                          children: [
                            Column(
                              children: [
                                ListTile(
                                    title:
                                        const Text("เมื่อต้องการทราบพื้นที่"),
                                    leading: Radio<ParalellogramFormula>(
                                      value: ParalellogramFormula.area,
                                      groupValue: _paralellogramFormula,
                                      onChanged: (ParalellogramFormula? value) {
                                        setState(() {
                                          _paralellogramFormula = value;
                                        });
                                      },
                                    )),
                                ListTile(
                                    title: const Text(
                                        "เมื่อต้องการทราบความยาวเส้นรอบรูป"),
                                    leading: Radio<ParalellogramFormula>(
                                      value: ParalellogramFormula.peri,
                                      groupValue: _paralellogramFormula,
                                      onChanged: (ParalellogramFormula? value) {
                                        setState(() {
                                          _paralellogramFormula = value;
                                        });
                                      },
                                    )),
                              ],
                            ),
                            getData(),
                          ],
                        )),
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

class CalcPageArea extends StatefulWidget {
  CalcPageArea({Key? key}) : super(key: key);

  @override
  _CalcPageArea createState() => _CalcPageArea();
}

class _CalcPageArea extends State<CalcPageArea> {
  num b = 0;
  num h = 0;

  Widget build(BuildContext context) {
    return Column(
      children: [
        NumberField(
            labelText: "b",
            onChanged: (value) => {
                  setState(() {
                    b = double.parse(value);
                  })
                }),
        NumberField(
          labelText: "h",
          onChanged: (value) => {
            setState(() {
              h = double.parse(value);
            })
          },
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "พื้นที่",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          "${b * h}",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class CalcPagePeri extends StatefulWidget {
  CalcPagePeri({Key? key}) : super(key: key);

  @override
  _CalcPagePeri createState() => _CalcPagePeri();
}

class _CalcPagePeri extends State<CalcPagePeri> {
  num a = 0;
  num b = 0;

  Widget build(BuildContext context) {
    return Column(
      children: [
        NumberField(
            labelText: "a",
            onChanged: (value) => {
                  setState(() {
                    a = double.parse(value);
                  })
                }),
        NumberField(
          labelText: "b",
          onChanged: (value) => {
            setState(() {
              b = double.parse(value);
            })
          },
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "เส้นรอบรูป",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          "${2 * (a + b)}",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
