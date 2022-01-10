// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
//import 'package:geomath/wikipediaPage.dart';

class SquareShapePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Table(border: TableBorder.all(), children: [
            TableRow(children: [
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text(
                    "พื้นที่",
                    textAlign: TextAlign.center,
                  )),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                          image: AssetImage(
                              'assets/images/equations/square_area.png')),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                          image: AssetImage(
                              'assets/images/equations/square_area_2.png')),
                    )
                  ]))
            ]),
            TableRow(children: [
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text(
                    "เส้นรอบรูป",
                    textAlign: TextAlign.center,
                  )),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: AssetImage(
                              'assets/images/equations/square_peri.png'),
                        ),
                      ),
                    ],
                  ))
            ])
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Image(image: AssetImage('assets/images/illustrator/square.png')),
          ),
          /*SizedBox(height: 30),
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WikipediaPage(
                              shape: 0,
                            )));
              },
              child: Center(
                child: Container(
                  width: 300,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('ดูเพิ่มเติมที่ Wikipedia'),
                        Icon(
                          Icons.chevron_right_outlined,
                        ),
                      ]),
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}

class RectangleShapePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Table(border: TableBorder.all(), children: [
          TableRow(children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Text("พื้นที่", textAlign: TextAlign.center),
            ),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                          image: AssetImage(
                              'assets/images/equations/rectangle_area.png')),
                    ),
                  ],
                )),
          ]),
          TableRow(children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Text(
                "เส้นรอบรูป",
                textAlign: TextAlign.center,
              ),
            ),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                          image: AssetImage(
                              'assets/images/equations/rectangle_peri.png')),
                    ),
                  ],
                )),
          ])
        ]),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Image(image: AssetImage('assets/images/illustrator/rectangle.png')),
        ),
        /*SizedBox(height: 30),
        Center(
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WikipediaPage(shape: 1)));
            },
            child: Center(
              child: Container(
                width: 300,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('ดูเพิ่มเติมที่ Wikipedia'),
                      Icon(
                        Icons.chevron_right_outlined,
                      ),
                    ]),
              ),
            ),
          ),
        ),*/
      ]),
    );
  }
}

class ParalellogramShapePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Table(border: TableBorder.all(), children: [
          TableRow(children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Text(
                "พื้นที่",
                textAlign: TextAlign.center,
              ),
            ),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                          image: AssetImage(
                              'assets/images/equations/paralell_area.png')),
                    ),
                  ],
                )),
          ]),
          TableRow(children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Text(
                "เส้นรอบรูป",
                textAlign: TextAlign.center,
              ),
            ),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                          image: AssetImage(
                              'assets/images/equations/rectangle_peri.png')),
                    ),
                  ],
                ))
          ]),
        ]),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(
              image: AssetImage('assets/images/illustrator/paralellogram.png')),
        ),
        /*SizedBox(height: 30),
        Center(
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WikipediaPage(shape: 2)));
            },
            child: Center(
              child: Container(
                width: 300,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('ดูเพิ่มเติมที่ Wikipedia'),
                      Icon(
                        Icons.chevron_right_outlined,
                      ),
                    ]),
              ),
            ),
          ),
        ),*/
      ]),
    );
  }
}

class RhombusShapePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Table(border: TableBorder.all(), children: [
          TableRow(children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Text(
                "พื้นที่",
                textAlign: TextAlign.center,
              ),
            ),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                        image: AssetImage(
                            'assets/images/equations/rhombus_area.png')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                        image: AssetImage(
                            'assets/images/equations/rhombus_area2.png')),
                  )
                ]))
          ]),
          TableRow(children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Text(
                "เส้นรอบรูป",
                textAlign: TextAlign.center,
              ),
            ),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Image.asset('assets/images/equations/square_peri.png'),
                    ),
                  ],
                ))
          ]),
        ]),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Image(image: AssetImage('assets/images/illustrator/rhombus.png')),
        ),
        /*SizedBox(height: 30),
        Center(
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WikipediaPage(shape: 3)));
            },
            child: Center(
              child: Container(
                width: 300,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('ดูเพิ่มเติมที่ Wikipedia'),
                      Icon(
                        Icons.chevron_right_outlined,
                      ),
                    ]),
              ),
            ),
          ),
        ),*/
      ]),
    );
  }
}

class TrapezoidShapePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Table(border: TableBorder.all(), children: [
          TableRow(children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Text(
                "พื้นที่",
                textAlign: TextAlign.center,
              ),
            ),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Image(
                    image:
                        AssetImage('assets/images/equations/trapezoid_area.png')))
          ]),
        ]),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(
            image: AssetImage('assets/images/illustrator/trapezoid.png'),
          ),
        ),
        /*SizedBox(height: 30),
        Center(
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WikipediaPage(shape: 4)));
            },
            child: Center(
              child: Container(
                width: 300,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('ดูเพิ่มเติมที่ Wikipedia'),
                      Icon(
                        Icons.chevron_right_outlined,
                      ),
                    ]),
              ),
            ),
          ),
        ),*/
      ]),
    );
  }
}

class KiteShapePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Table(border: TableBorder.all(), children: [
          TableRow(children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Text(
                "พื้นที่",
                textAlign: TextAlign.center,
              ),
            ),
            TableCell(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                      image: AssetImage('assets/images/equations/kite_area.png')),
                ),
              ],
            ))
          ]),
          TableRow(children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Text(
                "เส้นรอบรูป",
                textAlign: TextAlign.center,
              ),
            ),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Image.asset('assets/images/equations/rectangle_peri.png'))
          ])
        ]),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(
            image: AssetImage('assets/images/illustrator/kite.png'),
          ),
        ),
        /*SizedBox(height: 30),
        Center(
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WikipediaPage(shape: 5)));
            },
            child: Center(
              child: Container(
                width: 300,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('ดูเพิ่มเติมที่ Wikipedia'),
                      Icon(
                        Icons.chevron_right_outlined,
                      ),
                    ]),
              ),
            ),
          ),
        ),*/
      ]),
    );
  }
}

class TrapeziumShapePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Table(border: TableBorder.all(), children: [
          TableRow(children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Text(
                "พื้นที่",
                textAlign: TextAlign.center,
              ),
            ),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Image(
                    image:
                        AssetImage('assets/images/equations/trapezium_area.png')))
          ]),
        ]),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(
            image: AssetImage('assets/images/illustrator/trapezium.png'),
          ),
        ),
        /*SizedBox(height: 30),
        Center(
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WikipediaPage(shape: 6)));
            },
            child: Center(
              child: Container(
                width: 300,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('ดูเพิ่มเติมที่ Wikipedia'),
                      Icon(
                        Icons.chevron_right_outlined,
                      ),
                    ]),
              ),
            ),
          ),
        ),*/
      ]),
    );
  }
}

class TriangleShapePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Table(border: TableBorder.all(), children: [
          TableRow(children: [
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Text(
                  "พื้นที่",
                  textAlign: TextAlign.center,
                )),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                      image: AssetImage(
                          'assets/images/equations/triangle_area1.png')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                      image: AssetImage(
                          'assets/images/equations/triangle_area2.png')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                      image: AssetImage(
                          'assets/images/equations/triangle_area3.png')),
                )
              ]),
            ),
          ]),
          TableRow(children: [
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Text(
                  "เมื่อ",
                  textAlign: TextAlign.center,
                )),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                      image:
                          AssetImage('assets/images/equations/triangle_s.png')),
                ))
          ]),
        ]),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Image(image: AssetImage('assets/images/illustrator/triangle.png')),
        ),
        /*SizedBox(height: 30),
        Center(
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WikipediaPage(shape: 7)));
            },
            child: Center(
              child: Container(
                width: 300,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('ดูเพิ่มเติมที่ Wikipedia'),
                      Icon(
                        Icons.chevron_right_outlined,
                      ),
                    ]),
              ),
            ),
          ),
        ),*/
      ]),
    );
  }
}

class RtriShapePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Table(border: TableBorder.all(), children: [
            TableRow(children: [
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text(
                    "พื้นที่",
                    textAlign: TextAlign.center,
                  )),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                          image: AssetImage(
                              'assets/images/equations/rtriangle_area.png')),
                    ),
                  ]))
            ]),
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
                image: AssetImage('assets/images/illustrator/rtriangle.png')),
          ),
          /*SizedBox(height: 30),
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WikipediaPage(shape: 8)));
              },
              child: Center(
                child: Container(
                  width: 300,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('ดูเพิ่มเติมที่ Wikipedia'),
                        Icon(
                          Icons.chevron_right_outlined,
                        ),
                      ]),
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}

class CircleShapePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Table(border: TableBorder.all(), children: [
          TableRow(children: [
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Text(
                  "พื้นที่",
                  textAlign: TextAlign.center,
                )),
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                          image: AssetImage(
                              'assets/images/equations/circle_area.png')),
                    ),
                  ],
                ))
          ]),
          TableRow(children: [
            TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Text(
                  "เส้นรอบรูป",
                  textAlign: TextAlign.center,
                )),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/equations/circle_peri.png'),
                  ),
                ],
              ),
            )
          ]),
        ]),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image(image: AssetImage('assets/images/illustrator/circle.png')),
        ),
        /*SizedBox(height: 30),
        Center(
          child: TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WikipediaPage(shape: 9)));
            },
            child: Center(
              child: Container(
                width: 300,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('ดูเพิ่มเติมที่ Wikipedia'),
                      Icon(
                        Icons.chevron_right_outlined,
                      ),
                    ]),
              ),
            ),
          ),
        ),*/
      ]),
    );
  }
}

class EllipseShapePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Table(border: TableBorder.all(), children: [
            TableRow(children: [
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text(
                    "พื้นที่",
                    textAlign: TextAlign.center,
                  )),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                          image: AssetImage(
                              'assets/images/equations/eclipse_area.png')),
                    ),
                  ],
                ),
              )
            ]),
            TableRow(children: [
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Text(
                    "เส้นรอบรูป",
                    textAlign: TextAlign.center,
                  )),
              TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                            'assets/images/equations/eclipse_peri.png'),
                      ),
                    ],
                  ))
            ])
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Image(image: AssetImage('assets/images/illustrator/ellipse.png')),
          ),
          /*SizedBox(height: 30),
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WikipediaPage(shape: 10)));
              },
              child: Center(
                child: Container(
                  width: 300,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('ดูเพิ่มเติมที่ Wikipedia'),
                        Icon(
                          Icons.chevron_right_outlined,
                        ),
                      ]),
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}