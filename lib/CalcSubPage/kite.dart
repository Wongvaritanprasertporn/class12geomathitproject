import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        return Column(children: [
          TextField(
              decoration: new InputDecoration(labelText: "c"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ]),
          TextField(
            decoration: new InputDecoration(labelText: "d"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          )
        ]);
      case KiteAreaFormula.fromAB:
        return Column(children: [
          TextField(
              decoration: new InputDecoration(labelText: "a"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ]),
          TextField(
            decoration: new InputDecoration(labelText: "b"),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          )
        ]);
      default:
        print("Invalid");
    }
  }
}
