import 'package:flutter/material.dart';
import 'package:geomath/numberField.dart';

enum RhombusAreaFormula { fromAH, fromBC }

class RhombusCalcPage extends StatefulWidget {
  RhombusCalcPage({Key? key}) : super(key: key);

  @override
  _RhombusCalcPage createState() => _RhombusCalcPage();
}

class _RhombusCalcPage extends State<RhombusCalcPage> {
  RhombusAreaFormula? _rhombusAreaFormula = RhombusAreaFormula.fromAH;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Column(
            children: <Widget>[
              ListTile(
                title: const Text('เมื่อทราบความยาวด้านและความสูง'),
                leading: Radio<RhombusAreaFormula>(
                  value: RhombusAreaFormula.fromAH,
                  groupValue: _rhombusAreaFormula,
                  onChanged: (RhombusAreaFormula? value) {
                    setState(() {
                      _rhombusAreaFormula = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('เมื่อทราบความยาวเส้นทแยงมุมทั้งสองเส้น'),
                leading: Radio<RhombusAreaFormula>(
                  value: RhombusAreaFormula.fromBC,
                  groupValue: _rhombusAreaFormula,
                  onChanged: (RhombusAreaFormula? value) {
                    setState(() {
                      _rhombusAreaFormula = value;
                    });
                  },
                ),
              ),
            ],
          ),
          getData()
        ],
      ),
    );
  }

  getData() {
    switch (_rhombusAreaFormula) {
      case RhombusAreaFormula.fromAH:
        return RhombusAreaAH();
      case RhombusAreaFormula.fromBC:
        return RhombusAreaBC();
      default:
        print("Invalid");
    }
  }
}

class RhombusAreaAH extends StatefulWidget {
  RhombusAreaAH({Key? key}) : super(key: key);

  @override
  _RhombusAreaAH createState() => _RhombusAreaAH();
}

class _RhombusAreaAH extends State<RhombusAreaAH> {
  num a = 0;
  num h = 0;

  Widget build(BuildContext context) {
    return Column(
      children: [
        NumberField(
            labelText: "a (Side)",
            onChanged: (value) => {
                  setState(() {
                    a = double.parse(value);
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
          "${a * h}",
          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
        Text(
          "เส้นรอบรูป",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          "${a * 4}",
          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class RhombusAreaBC extends StatefulWidget {
  RhombusAreaBC({Key? key}) : super(key: key);

  @override
  _RhombusAreaBC createState() => _RhombusAreaBC();
}

class _RhombusAreaBC extends State<RhombusAreaBC> {
  num b = 0;
  num c = 0;

  Widget build(BuildContext context) {
    return Column(
      children: [
        NumberField(
          labelText: "b",
          onChanged: (value) => {
            setState(() {
              b = double.parse(value);
            })
          },
        ),
        NumberField(
            labelText: "c",
            onChanged: (value) => {
                  setState(() {
                    c = double.parse(value);
                  })
                }),
        Text(
          "พื้นที่",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          "${0.5 * b * c}",
          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
