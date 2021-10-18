import 'package:flutter/material.dart';
import 'package:geomath/numberField.dart';
import 'dart:math';

enum SquareAreaFormula { fromA, fromB }

class SquareCalcPage extends StatefulWidget {
  SquareCalcPage({Key? key}) : super(key: key);

  @override
  _SquareCalcPage createState() => _SquareCalcPage();
}

class _SquareCalcPage extends State<SquareCalcPage> {
  SquareAreaFormula? _squareAreaFormula = SquareAreaFormula.fromA;

  @override
  void initState() {
    super.initState();
  }

  getData() {
    switch (_squareAreaFormula) {
      case SquareAreaFormula.fromA:
        return CalcPageFromA();
      case SquareAreaFormula.fromB:
        return CalcPageFromB();
      default:
        print("Unknown square area formula");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Column(
            children: [
              ListTile(
                title: const Text("เมื่อทราบความยาวด้าน"),
                leading: Radio<SquareAreaFormula>(
                  value: SquareAreaFormula.fromA,
                  groupValue: _squareAreaFormula,
                  onChanged: (SquareAreaFormula? value) {
                    setState(() {
                      _squareAreaFormula = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text("เมื่อทราบความยาวเส้นทแยงมุม"),
                leading: Radio<SquareAreaFormula>(
                  value: SquareAreaFormula.fromB,
                  groupValue: _squareAreaFormula,
                  onChanged: (SquareAreaFormula? value) {
                    setState(() {
                      _squareAreaFormula = value;
                    });
                  },
                ),
              )
            ],
          ),
          getData(),
        ],
      ),
    );
  }
}

class CalcPageFromA extends StatefulWidget {
  CalcPageFromA({Key? key}) : super(key: key);

  @override
  _CalcPageFromA createState() => _CalcPageFromA();
}

class _CalcPageFromA extends State<CalcPageFromA> {
  num numberFieldValA = 0;

  Widget build(BuildContext context) {
    return Column(
      children: [
        NumberField(
          labelText: "a",
          onChanged: (value) => {
            setState(() {
              numberFieldValA = double.parse(value);
            })
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              Text(
                "พื้นที่",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "${pow(numberFieldValA, 2)}",
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              Text(
                "เส้นรอบรูป",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "${numberFieldValA * 4}",
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CalcPageFromB extends StatefulWidget {
  CalcPageFromB({Key? key}) : super(key: key);

  @override
  _CalcPageFromB createState() => _CalcPageFromB();
}

class _CalcPageFromB extends State<CalcPageFromB> {
  num numberFieldValB = 0;
  Widget build(BuildContext context) {
    return Column(
      children: [
        NumberField(
          labelText: "b",
          onChanged: (value) => {
            setState(() {
              numberFieldValB = double.parse(value);
            })
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              Text(
                "พื้นที่",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "${0.5 * pow(numberFieldValB, 2)}",
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ],
    );
  }
}
