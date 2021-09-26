import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrapezoidCalcPage extends StatefulWidget {
  TrapezoidCalcPage({Key? key}) : super(key: key);

  @override
  _TrapezoidCalcPage createState() => _TrapezoidCalcPage();
}

class _TrapezoidCalcPage extends State<TrapezoidCalcPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(children: [
          TextField(
              decoration: new InputDecoration(labelText: "a (side)"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ]),
          TextField(
              decoration: new InputDecoration(labelText: "b (diagonal)"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ]),
        ])
      ],
    );
  }
}
