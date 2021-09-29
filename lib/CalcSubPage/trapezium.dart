import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrapeziumCalcPage extends StatefulWidget {
  TrapeziumCalcPage({Key? key}) : super(key: key);

  @override
  _TrapeziumCalcPage createState() => _TrapeziumCalcPage();
}

class _TrapeziumCalcPage extends State<TrapeziumCalcPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
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
      ),
    );
  }
}
