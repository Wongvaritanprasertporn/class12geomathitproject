import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ParaCalcPage extends StatefulWidget {
  ParaCalcPage({Key? key}) : super(key: key);

  @override
  _ParaCalcPage createState() => _ParaCalcPage();
}

class _ParaCalcPage extends State<ParaCalcPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
                decoration: new InputDecoration(labelText: "a"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ]),
            TextField(
              onChanged: (text) {
                print("$text");
              },
              decoration: new InputDecoration(labelText: "b"),
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
                ]),
      ],
    );
  }
}
