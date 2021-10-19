import 'package:flutter/material.dart';
import 'package:geomath/numberField.dart';
import 'dart:math';

class CircleCalcPage extends StatefulWidget {
  CircleCalcPage({Key? key}) : super(key: key);

  @override
  _CircleCalcPage createState() => _CircleCalcPage();
}

class _CircleCalcPage extends State<CircleCalcPage> {
  num r = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Column(
            children: [
              NumberField(
                  labelText: "r (Radius)",
                  onChanged: (value) => {
                        setState(() {
                          r = double.parse(value);
                        })
                      })
            ],
          ),
          Text(
            "พื้นที่",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            "${pi * pow(r, 2)}",
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          Text(
            "เส้นรอบรูป",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            "${2 * pi * r}",
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
