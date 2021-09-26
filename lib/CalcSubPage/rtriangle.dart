import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RtriCalcPage extends StatefulWidget {
  RtriCalcPage({Key? key}) : super(key: key);

  @override
  _RtriCalcPage createState() => _RtriCalcPage();
}

class _RtriCalcPage extends State<RtriCalcPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
            )
          ],
        )
      ],
    );
  }
}
