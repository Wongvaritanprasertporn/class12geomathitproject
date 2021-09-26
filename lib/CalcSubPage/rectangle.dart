import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RectangleCalcPage extends StatefulWidget {
  RectangleCalcPage({Key? key}) : super(key: key);

  @override
  _RectangleCalcPage createState() => _RectangleCalcPage();
}

class _RectangleCalcPage extends State<RectangleCalcPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Column(
            children: [
              TextField(
                decoration: new InputDecoration(labelText: "a (Height)"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ]),
              TextField(
                onChanged: (text) {
                  print("$text");
                },
                decoration: new InputDecoration(labelText: "b (Width)"),
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
