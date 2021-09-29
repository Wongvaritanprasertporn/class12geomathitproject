import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EllipseCalcPage extends StatefulWidget {
  EllipseCalcPage({Key? key}) : super(key: key);

  @override
  _EllipseCalcPage createState() => _EllipseCalcPage();
}

class _EllipseCalcPage extends State<EllipseCalcPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
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
          ),
        )
      ],
    );
  }
}
