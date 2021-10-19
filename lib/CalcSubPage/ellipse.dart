import 'package:flutter/material.dart';
import 'package:geomath/numberField.dart';
import 'dart:math';

class EllipseCalcPage extends StatefulWidget {
  EllipseCalcPage({Key? key}) : super(key: key);

  @override
  _EllipseCalcPage createState() => _EllipseCalcPage();
}

class _EllipseCalcPage extends State<EllipseCalcPage> {
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
                labelText: "a (Widest Radius)",
                onChanged: (value) => {
                  setState(() {
                    a = double.parse(value);
                  })
                },
              ),
              NumberField(
                  labelText: "b (Shortest Radius)",
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
                "${(pi * a * b) / 4}",
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              Text(
                "เส้นรอบรูป",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "${(pi * (a + b)) / 2}",
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              )
            ],
          ),
        )
      ],
    );
  }
}
