import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CircleCalcPage extends StatefulWidget {
  CircleCalcPage({Key? key}) : super(key: key);

  @override
  _CircleCalcPage createState() => _CircleCalcPage();
}

class _CircleCalcPage extends State<CircleCalcPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            TextField(
              decoration: new InputDecoration(labelText: "r"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ],
        )
      ],
    );
  }
}
