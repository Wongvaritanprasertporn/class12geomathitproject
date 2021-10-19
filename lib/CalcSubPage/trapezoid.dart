import 'package:flutter/material.dart';
import 'package:geomath/numberField.dart';

class TrapezoidCalcPage extends StatefulWidget {
  TrapezoidCalcPage({Key? key}) : super(key: key);

  @override
  _TrapezoidCalcPage createState() => _TrapezoidCalcPage();
}

class _TrapezoidCalcPage extends State<TrapezoidCalcPage> {
  num a = 0;
  num b = 0;
  num h = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Column(children: [
            NumberField(
                labelText: "a",
                onChanged: (value) => {
                      setState(() {
                        a = double.parse(value);
                      })
                    }),
            NumberField(
                labelText: "b",
                onChanged: (value) => {
                      setState(() {
                        b = double.parse(value);
                      })
                    }),
            NumberField(
                labelText: "h (Height)",
                onChanged: (value) => {
                      setState(() {
                        h = double.parse(value);
                      })
                    }),
            Text(
              "พื้นที่",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Text(
              "${0.5 * h * (a + b)}",
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ])
        ],
      ),
    );
  }
}
