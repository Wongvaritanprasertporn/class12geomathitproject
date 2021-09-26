import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum TriangleAreaFormula { fromAH, fromSide }

class TrapeziumCalcPage extends StatefulWidget {
  TrapeziumCalcPage({Key? key}) : super(key: key);

  @override
  _TrapeziumCalcPage createState() => _TrapeziumCalcPage();
}

class _TrapeziumCalcPage extends State<TrapeziumCalcPage> {
  TriangleAreaFormula? _triangleAreaFormula = TriangleAreaFormula.fromAH;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            Column(
              children: [
                TextField(
                  decoration: new InputDecoration(labelText: "a"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                TextField(
                  decoration: new InputDecoration(labelText: "h (Height)"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                )
              ],
            ),
            Column(
              children: [
                TextField(
                  decoration: new InputDecoration(labelText: "a"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                TextField(
                  decoration: new InputDecoration(labelText: "b"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                TextField(
                  decoration: new InputDecoration(labelText: "c"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
