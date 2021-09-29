import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        return Column(
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
        );
      case TriangleAreaFormula.fromSide:
        return Column(
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
        );
      default:
        print("invalid");
    }
  }
}
