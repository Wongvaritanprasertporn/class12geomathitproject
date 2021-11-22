import 'package:flutter/material.dart';
import 'package:geomath/numberField.dart';

enum RhombusAreaFormula { fromAH, fromBC }

class RhombusAreaAH extends StatefulWidget {
  RhombusAreaAH({Key? key}) : super(key: key);

  @override
  _RhombusAreaAH createState() => _RhombusAreaAH();
}

class _RhombusAreaAH extends State<RhombusAreaAH> {
  num a = 0;
  num h = 0;

  Widget build(BuildContext context) {
    return Column(
      children: [
        NumberField(
            labelText: "a (ด้าน)",
            onChanged: (value) => {
                  setState(() {
                    a = double.parse(value);
                  })
                }),
        NumberField(
            labelText: "h (ความสูง)",
            onChanged: (value) => {
                  setState(() {
                    h = double.parse(value);
                  })
                }),
        SizedBox(
          height: 10,
        ),
        Text(
          "พื้นที่",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          "${a * h}",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        Text(
          "เส้นรอบรูป",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          "${a * 4}",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class RhombusAreaBC extends StatefulWidget {
  RhombusAreaBC({Key? key}) : super(key: key);

  @override
  _RhombusAreaBC createState() => _RhombusAreaBC();
}

class _RhombusAreaBC extends State<RhombusAreaBC> {
  num b = 0;
  num c = 0;

  Widget build(BuildContext context) {
    return Column(
      children: [
        NumberField(
          labelText: "b",
          onChanged: (value) => {
            setState(() {
              b = double.parse(value);
            })
          },
        ),
        NumberField(
            labelText: "c",
            onChanged: (value) => {
                  setState(() {
                    c = double.parse(value);
                  })
                }),
        SizedBox(
          height: 10,
        ),
        Text(
          "พื้นที่",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          "${0.5 * b * c}",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class RhombusCalcPage extends StatefulWidget {
  RhombusCalcPage({Key? key}) : super(key: key);

  @override
  _RhombusCalcPage createState() => _RhombusCalcPage();
}

class _RhombusCalcPage extends State<RhombusCalcPage> {
  RhombusAreaFormula? _rhombusAreaFormula = RhombusAreaFormula.fromAH;
  bool showBottomMenu = true;
  final GlobalKey _widgetKey = GlobalKey();
  final GlobalKey _animatedPos = GlobalKey();
  Size? _size;

  var threshold = 100;

  getData() {
    switch (_rhombusAreaFormula) {
      case RhombusAreaFormula.fromAH:
        return RhombusAreaAH();
      case RhombusAreaFormula.fromBC:
        return RhombusAreaBC();
      default:
        print("Invalid");
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
                            children: <Widget>[
                              ListTile(
                                title: const Text(
                                    'เมื่อทราบความยาวด้านและความสูง'),
                                leading: Radio<RhombusAreaFormula>(
                                  value: RhombusAreaFormula.fromAH,
                                  groupValue: _rhombusAreaFormula,
                                  onChanged: (RhombusAreaFormula? value) {
                                    setState(() {
                                      _rhombusAreaFormula = value;
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
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          getData()
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
