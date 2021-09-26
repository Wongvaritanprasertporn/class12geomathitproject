import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum SquareAreaFormula { fromA, fromB }

class SquareCalcPage extends StatefulWidget {
  SquareCalcPage({Key? key}) : super(key: key);

  @override
  _SquareCalcPage createState() => _SquareCalcPage();
}

class _SquareCalcPage extends State<SquareCalcPage> {
  SquareAreaFormula? _squareAreaFormula = SquareAreaFormula.fromA;

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
          getData()
        ],
      ),
    );
  }

  getData() {
    switch (_squareAreaFormula) {
      case SquareAreaFormula.fromA:
        return TextField(
          decoration: new InputDecoration(labelText: "a"),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        );
      case SquareAreaFormula.fromB:
        return TextField(
          decoration: new InputDecoration(labelText: "b"),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        );
      default:
        print("Unknown square area formula");
    }
  }
}
