import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SquareCalcPage extends StatefulWidget {
  SquareCalcPage({Key? key}) : super(key: key);

  @override
  _SquareCalcPage createState() => _SquareCalcPage();
}

class _SquareCalcPage extends State<SquareCalcPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
