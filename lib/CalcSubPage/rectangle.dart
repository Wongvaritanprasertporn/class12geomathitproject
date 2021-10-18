import 'package:flutter/material.dart';
import 'package:geomath/numberField.dart';

class RectangleCalcPage extends StatefulWidget {
  RectangleCalcPage({Key? key}) : super(key: key);

  @override
  _RectangleCalcPage createState() => _RectangleCalcPage();
}

class _RectangleCalcPage extends State<RectangleCalcPage> {
  num numberFieldValA = 0;
  num numberFieldValB = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Column(
            children: [
              NumberField(
                  labelText: "a",
                  onChanged: (value) => {
                        setState(() {
                          numberFieldValA = double.parse(value);
                        })
                      }),
              NumberField(
                  labelText: "b",
                  onChanged: (value) => {
                        setState(() {
                          numberFieldValB = double.parse(value);
                        })
                      }),
              Text(
                "พื้นที่",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "${numberFieldValA * numberFieldValB}",
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              Text(
                "เส้นรอบรูป",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Text(
                "${2 * (numberFieldValA + numberFieldValB)}",
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
