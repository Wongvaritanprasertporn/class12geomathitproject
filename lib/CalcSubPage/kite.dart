import 'package:flutter/material.dart';
import 'package:geomath/numberField.dart';

enum KiteAreaFormula { fromCD, fromAB }

class KiteCalcPage extends StatefulWidget {
  KiteCalcPage({Key? key}) : super(key: key);

  @override
  _KiteCalcPage createState() => _KiteCalcPage();
}

class _KiteCalcPage extends State<KiteCalcPage> {
  KiteAreaFormula? _kiteAreaFormula = KiteAreaFormula.fromCD;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Column(
            children: [
              Column(
                children: <Widget>[
                  ListTile(
                    title: const Text('หาพื้นที่'),
                    leading: Radio<KiteAreaFormula>(
                      value: KiteAreaFormula.fromCD,
                      groupValue: _kiteAreaFormula,
                      onChanged: (KiteAreaFormula? value) {
                        setState(() {
                          _kiteAreaFormula = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('หาเส้นรอบรูป'),
                    leading: Radio<KiteAreaFormula>(
                      value: KiteAreaFormula.fromAB,
                      groupValue: _kiteAreaFormula,
                      onChanged: (KiteAreaFormula? value) {
                        setState(() {
                          _kiteAreaFormula = value;
                        });
                      },
                    ),
                  ),
                  getData()
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  getData() {
    switch (_kiteAreaFormula) {
      case KiteAreaFormula.fromCD:
        return CalcPageFromCD();
      case KiteAreaFormula.fromAB:
        return CalcPageFromAB();
      default:
        print("Invalid");
    }
  }
}

class CalcPageFromCD extends StatefulWidget {
  CalcPageFromCD({Key? key}) : super(key: key);

  @override
  _CalcPageFromCD createState() => _CalcPageFromCD();
}

class _CalcPageFromCD extends State<CalcPageFromCD> {
  num c = 0;
  num d = 0;

  Widget build(BuildContext context) {
    return Column(children: [
      NumberField(
        labelText: "c",
        onChanged: (value) => {
          setState(() {
            c = double.parse(value);
          })
        },
      ),
      NumberField(
          labelText: "d",
          onChanged: (value) => {
                setState(() {
                  d = double.parse(value);
                })
              }),
      Text(
        "พื้นที่",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      Text(
        "${0.5 * c * d}",
        style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
      ),
    ]);
  }
}

class CalcPageFromAB extends StatefulWidget {
  CalcPageFromAB({Key? key}) : super(key: key);

  @override
  _CalcPageFromAB createState() => _CalcPageFromAB();
}

class _CalcPageFromAB extends State<CalcPageFromAB> {
  num a = 0;
  num b = 0;

  Widget build(BuildContext context) {
    return Column(children: [
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
      Text(
        "เส้นรอบรูป",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      Text(
        "${2 * (a + b)}",
        style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
      )
    ]);
  }
}
