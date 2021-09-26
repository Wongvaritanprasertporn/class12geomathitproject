import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum RhombusAreaFormula { fromAH, fromBC }

class RhombusCalcPage extends StatefulWidget {
  RhombusCalcPage({Key? key}) : super(key: key);

  @override
  _RhombusCalcPage createState() => _RhombusCalcPage();
}

class _RhombusCalcPage extends State<RhombusCalcPage> {
  RhombusAreaFormula? _rhombusAreaFormula = RhombusAreaFormula.fromAH;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: <Widget>[
            ListTile(
              title: const Text('Lafayette'),
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
              title: const Text('Thomas Jefferson'),
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
        Column(
          children: [
            TextField(
                decoration: new InputDecoration(labelText: "a (Height)"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ]),
            TextField(
                decoration: new InputDecoration(labelText: "a (Height)"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ]),
          ],
        ),
        Column(
          children: [
            TextField(
                decoration: new InputDecoration(labelText: "a (Height)"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ]),
            TextField(
                decoration: new InputDecoration(labelText: "a (Height)"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ]),
          ],
        ),
      ],
    );
  }
}
