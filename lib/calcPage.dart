import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum RhombusAreaFormula { fromAH, fromBC }
enum KiteAreaFormula { fromCD, fromAB }
enum TriangleAreaFormula { fromAH, fromSide }

class CalcPage extends StatefulWidget {
  int pageStatus = 0;
  CalcPage({Key? key, required this.pageStatus}) : super(key: key);

  @override
  _CalcPage createState() => _CalcPage(pageStatus);
}

class _CalcPage extends State<CalcPage> {
  int pageStatus = 0;
  _CalcPage(pageStatus);

  RhombusAreaFormula? _rhombusAreaFormula = RhombusAreaFormula.fromAH;
  KiteAreaFormula? _kiteAreaFormula = KiteAreaFormula.fromCD;
  TriangleAreaFormula? _triangleAreaFormula = TriangleAreaFormula.fromAH;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [getData()],
      ),
    );
  }

  getData() {
    switch (pageStatus) {

      //Rectangle สี่เหลี่ยมผืนผ้า

      case 1:
        return Column(
          children: [
            new TextField(
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
        );

      //Paralellogram สี่เหลี่ยมด้านขนาน

      case 2:
        return Column(
          children: [
            new TextField(
                decoration: new InputDecoration(labelText: "a"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ]),
            TextField(
              onChanged: (text) {
                print("$text");
              },
              decoration: new InputDecoration(labelText: "b"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            TextField(
                decoration: new InputDecoration(labelText: "h (Height)"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ]),
          ],
        );

      //Rhombus สี่เหลี่ยมขมนเปียกปูน

      case 3:
        return Column(
          children: [
            Column(
              children: <Widget>[
                ListTile(
                  title: const Text('Lafayette'),
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
                  title: const Text('Thomas Jefferson'),
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
            Column(
              children: [
                TextField(
                    decoration: new InputDecoration(labelText: "a (Height)"),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ]),
                TextField(
                    decoration: new InputDecoration(labelText: "a (Height)"),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ]),
              ],
            ),
            Column(
              children: [
                TextField(
                    decoration: new InputDecoration(labelText: "a (Height)"),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ]),
                TextField(
                    decoration: new InputDecoration(labelText: "a (Height)"),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ]),
              ],
            ),
          ],
        );

      //Trapezoid สี่เหลี่ยมคางหมู

      case 4:
        return Column(children: [
          TextField(
              decoration: new InputDecoration(labelText: "a (side)"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ]),
          TextField(
              decoration: new InputDecoration(labelText: "b (diagonal)"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ]),
        ]);

      //Kite สี่เหลี่ยมรูปว่าว

      case 5:
        return Column(
          children: [
            Column(
              children: <Widget>[
                ListTile(
                  title: const Text('เมื่อทราบความยาวของรูป'),
                  leading: Radio<KiteAreaFormula>(
                    value: KiteAreaFormula.fromCD,
                    groupValue: _kiteAreaFormula,
                    onChanged: (KiteAreaFormula? value) {
                      setState(() {
                        _kiteAreaFormula = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('เมื่อทราบความยาวของด้าน'),
                  leading: Radio<KiteAreaFormula>(
                    value: KiteAreaFormula.fromAB,
                    groupValue: _kiteAreaFormula,
                    onChanged: (KiteAreaFormula? value) {
                      setState(() {
                        _kiteAreaFormula = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Column(children: [
              TextField(
                  decoration: new InputDecoration(labelText: "c"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ]),
              TextField(
                decoration: new InputDecoration(labelText: "d"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              )
            ]),
            Column(children: [
              TextField(
                  decoration: new InputDecoration(labelText: "a"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ]),
              TextField(
                decoration: new InputDecoration(labelText: "b"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              )
            ]),
          ],
        );

      //สี่เหลี่ยมด้านไม่เท่า Trapezium

      case 6:
        return Column(
          children: [
            TextField(
                decoration: new InputDecoration(labelText: "a"),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ]),
            TextField(
              decoration: new InputDecoration(labelText: "b"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            TextField(
              decoration: new InputDecoration(labelText: "c"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            )
          ],
        );

      //สามเหลี่ยม Triangle

      case 7:
        return Column(
          children: [
            Column(children: <Widget>[
              ListTile(
                title: const Text('เมื่อทราบความกว้างและความสูง'),
                leading: Radio<TriangleAreaFormula>(
                  value: TriangleAreaFormula.fromAH,
                  groupValue: _triangleAreaFormula,
                  onChanged: (TriangleAreaFormula? value) {
                    setState(() {
                      _triangleAreaFormula = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('เมื่อทราบความความยาวของด้านทั้งสาม'),
                leading: Radio<TriangleAreaFormula>(
                  value: TriangleAreaFormula.fromSide,
                  groupValue: _triangleAreaFormula,
                  onChanged: (TriangleAreaFormula? value) {
                    setState(() {
                      _triangleAreaFormula = value;
                    });
                  },
                ),
              ),
            ]),
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
                  decoration: new InputDecoration(labelText: "h (Height)"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                )
              ],
            ),
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
                ),
                TextField(
                  decoration: new InputDecoration(labelText: "c"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                )
              ],
            )
          ],
        );

      //สามเหลี่ยมมุมฉาก Right Triangle

      case 8:
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

      //วงกลม Circle

      case 9:
        return Column(
          children: [
            TextField(
              decoration: new InputDecoration(labelText: "r"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ],
        );

      //วงรี Ellipse

      case 10:
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

      //Square สี่เหลี่ยมจตุรัส

      default:
        return Column(
          children: [Text("data")],
        );
    }
  }
}
