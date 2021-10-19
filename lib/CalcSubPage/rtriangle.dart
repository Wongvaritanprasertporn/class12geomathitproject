import 'package:flutter/material.dart';
import 'package:geomath/numberField.dart';

class RtriCalcPage extends StatefulWidget {
  RtriCalcPage({Key? key}) : super(key: key);

  @override
  _RtriCalcPage createState() => _RtriCalcPage();
}

class _RtriCalcPage extends State<RtriCalcPage> {
  num a = 0;
  num b = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
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
              Text(
                "พื้นที่",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "${0.5 * a * b}",
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )
      ],
    );
  }
}
