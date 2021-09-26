import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum RhombusAreaFormula { fromAH, fromBC, perimeter }

class RhombusCalcPage extends StatefulWidget {
  RhombusCalcPage({Key? key}) : super(key: key);

  @override
  _RhombusCalcPage createState() => _RhombusCalcPage();
}

class _RhombusCalcPage extends State<RhombusCalcPage> {
  RhombusAreaFormula? _rhombusAreaFormula = RhombusAreaFormula.fromAH;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
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
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('เมื่อทราบความยาวเส้นทแยงมุมทั้งสองเส้น'),
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
              ListTile(
                title: const Text('หาเส้นรอบรูป'),
                leading: Radio<RhombusAreaFormula>(
                  value: RhombusAreaFormula.perimeter,
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
    );
  }

  getData() {
    switch (_rhombusAreaFormula) {
      case RhombusAreaFormula.fromAH:
        return Column(
          children: [
            TextField(
                decoration: new InputDecoration(labelText: "a (Side)"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ]),
            TextField(
                decoration: new InputDecoration(labelText: "h (Height)"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ]),
          ],
        );
      case RhombusAreaFormula.fromBC:
        return Column(
          children: [
            TextField(
                decoration: new InputDecoration(labelText: "b"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ]),
            TextField(
                decoration: new InputDecoration(labelText: "c"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ]),
          ],
        );
      case RhombusAreaFormula.perimeter:
        return Column(
          children: [
            TextField(
                decoration: new InputDecoration(labelText: "a (Side)"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ])
          ],
        );
      default:
        print("Invalid");
    }
  }
}
