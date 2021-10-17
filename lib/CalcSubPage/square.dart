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

  String numberFieldValA = "";
  String numberFieldValB = "";
  num aValueArea = 0;
  num aValuePeri = 0;
  num bValueArea = 0;

  @override
  void initState() {
    super.initState();
  }

  void calculate(value) {
    setState(() {
      numberFieldValA = value;
      print("number : $numberFieldValA");
      aValueArea = pow(double.parse(numberFieldValA), 2);
      aValuePeri = double.parse(numberFieldValA) * 4;
    });
  }

  getData() {
    switch (_squareAreaFormula) {
      case SquareAreaFormula.fromA:
        return Column(
          children: [
            NumberField(
              labelText: "a",
              onChanged: (value) => calculate(value),
              //key: UniqueKey(),
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
                    "$aValueArea",
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "เส้นรอบรูป",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "$aValuePeri",
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        );
      case SquareAreaFormula.fromB:
        return Column(
          children: [
            NumberField(
              labelText: "b",
              onChanged: (value) => calculate(value),
              //key: UniqueKey(),
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
                    "$bValueArea",
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ],
        );
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
