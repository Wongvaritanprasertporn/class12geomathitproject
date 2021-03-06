import 'package:flutter/material.dart';
import 'package:geomath/CalcSubPage/square.dart';
import 'package:geomath/CalcSubPage/rectangle.dart';
import 'package:geomath/CalcSubPage/paralellogram.dart';
import 'package:geomath/CalcSubPage/rhombus.dart';
import 'package:geomath/CalcSubPage/trapezoid.dart';
import 'package:geomath/CalcSubPage/kite.dart';
import 'package:geomath/CalcSubPage/trapezium.dart';
import 'package:geomath/CalcSubPage/triangle.dart';
import 'package:geomath/CalcSubPage/rtriangle.dart';
import 'package:geomath/CalcSubPage/circle.dart';
import 'package:geomath/CalcSubPage/ellipse.dart';
import 'shapePage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var shapeList = [
    "สี่เหลี่ยมจตุรัส",
    "สี่เหลี่ยมผืนผ้า",
    "สี่เหลี่ยมด้านขนาน",
    "สี่เหลี่ยมขนมเปียกปูน",
    "สี่เหลี่ยมคางหมู",
    "สี่เหลี่ยมรูปว่าว",
    "สี่เหลี่ยมด้านไม่เท่า",
    "สามเหลี่ยม",
    "สามเหลี่ยมมุมฉาก",
    "วงกลม",
    "วงรี"
  ];

  String title = "สี่เหลี่ยมจตุรัส";
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: new AppBar(
              title: Text("$title"),
              actions: [
                PopupMenuButton(
                  onSelected: (item) => onSelected(context, item),
                  itemBuilder: (context) => makePopupMenuItem(shapeList),
                  icon: const Icon(Icons.arrow_drop_down_outlined),
                  offset: const Offset(0, 50),
                )
              ],
              bottom: TabBar(tabs: [
                Tab(text: "แสดงผลภาพ"),
                Tab(text: "คุณสมบัติ"),
              ]),
            ),
            body: TabBarView(children: [
              selectCalcPage(_selectedPage),
              SingleChildScrollView(
                child: selectShapePage(_selectedPage),
              )
            ])));
  }

  List<PopupMenuEntry> makePopupMenuItem(import) {
    List<PopupMenuEntry> data = [];
    for (var i = 0; i < import.length; i++) {
      data.add(PopupMenuItem(value: i, child: Text("${import[i]}")));
    }
    return data;
  }

  onSelected(BuildContext context, item) {
    print("This is : $item");
    setState(() {
      _selectedPage = item;
      title = shapeList[item];
    });
  }

  selectCalcPage(_selectedPage) {
    switch (_selectedPage) {
      case 0:
        return SquareCalcPage();
      case 1:
        return RectangleCalcPage();
      case 2:
        return ParaCalcPage();
      case 3:
        return RhombusCalcPage();
      case 4:
        return TrapezoidCalcPage();
      case 5:
        return KiteCalcPage();
      case 6:
        return TrapeziumCalcPage();
      case 7:
        return TriangleCalcPage();
      case 8:
        return RtriCalcPage();
      case 9:
        return CircleCalcPage();
      case 10:
        return EllipseCalcPage();
    }
  }

  selectShapePage(_selectedPage) {
    switch (_selectedPage) {
      case 0:
        return SquareShapePage();
      case 1:
        return RectangleShapePage();
      case 2:
        return ParalellogramShapePage();
      case 3:
        return RhombusShapePage();
      case 4:
        return TrapezoidShapePage();
      case 5:
        return KiteShapePage();
      case 6:
        return TrapeziumShapePage();
      case 7:
        return TriangleShapePage();
      case 8:
        return RtriShapePage();
      case 9:
        return CircleShapePage();
      case 10:
        return EllipseShapePage();
    }
  }
}
