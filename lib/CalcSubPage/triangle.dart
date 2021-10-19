import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geomath/numberField.dart';

enum TriangleAreaFormula { fromAH, fromSide }

class TriangleCalcPage extends StatefulWidget {
  TriangleCalcPage({Key? key}) : super(key: key);

  @override
  _TriangleCalcPage createState() => _TriangleCalcPage();
}

class _TriangleCalcPage extends State<TriangleCalcPage> {
  TriangleAreaFormula? _triangleAreaFormula = TriangleAreaFormula.fromAH;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Column(
            children: [
              Column(children: <Widget>[
                ListTile(
                  title: const Text('เมื่อทราบความกว้างและความสูง'),
                  leading: Radio<TriangleAreaFormula>(
                    value: TriangleAreaFormula.fromAH,
                    groupValue: _triangleAreaFormula,
                    onChanged: (TriangleAreaFormula? value) {
                      setState(() {
                        _triangleAreaFormula = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('เมื่อทราบความความยาวของด้านทั้งสาม'),
                  leading: Radio<TriangleAreaFormula>(
                    value: TriangleAreaFormula.fromSide,
                    groupValue: _triangleAreaFormula,
                    onChanged: (TriangleAreaFormula? value) {
                      setState(() {
                        _triangleAreaFormula = value;
                      });
                    },
                  ),
                ),
              ]),
            ],
          ),
          getData(),
        ],
      ),
    );
  }

  getData() {
    switch (_triangleAreaFormula) {
      case TriangleAreaFormula.fromAH:
        return CalcPageFromAH();
      case TriangleAreaFormula.fromSide:
        return CalcPageFromSide();
      default:
        print("invalid");
    }
  }
}

class CalcPageFromAH extends StatefulWidget {
  CalcPageFromAH({Key? key}) : super(key: key);

  @override
  _CalcPageFromAH createState() => _CalcPageFromAH();
}

class _CalcPageFromAH extends State<CalcPageFromAH> {
  num a = 0;
  num h = 0;

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
            labelText: "h (Height)",
            onChanged: (value) => {
                  setState(() {
                    h = double.parse(value);
                  })
                }),
        Text(
          "พื้นที่",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          "${(a * h) / 2}",
          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class CalcPageFromSide extends StatefulWidget {
  CalcPageFromSide({Key? key}) : super(key: key);

  @override
  _CalcPageFromSide createState() => _CalcPageFromSide();
}

class _CalcPageFromSide extends State<CalcPageFromSide> {
  num a = 0;
  num b = 0;
  num c = 0;
  num s = 0;

  Widget build(BuildContext context) {
    return Column(
      children: [
        NumberField(
            labelText: "a",
            onChanged: (value) => {
                  setState(() {
                    a = double.parse(value);
                    s = 0.5 * (a + b + c);
                  })
                }),
        NumberField(
            labelText: "b",
            onChanged: (value) => {
                  setState(() {
                    b = double.parse(value);
                    s = 0.5 * (a + b + c);
                  })
                }),
        NumberField(
            labelText: "c",
            onChanged: (value) => {
                  setState(() {
                    c = double.parse(value);
                    s = 0.5 * (a + b + c);
                  })
                }),
        Text(
          "พื้นที่",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          "${sqrt(s * (s - a) * (s - b) * (s - c))}",
          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
        Text(
          "เส้นรอบรูป",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          "${a + b + c}",
          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
