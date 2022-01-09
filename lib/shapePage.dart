// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ShapePage extends StatelessWidget {
  int pageStatus = 0;

  ShapePage(this.pageStatus);

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: getData(),
    );
  }

  getData() {
    switch (pageStatus) {
      case 1:

        //Rectangle สี่เหลี่ยมผืนผ้า

        return Column(children: [
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
            child: Image(
                image: AssetImage('assets/images/illustrator/rectangle.png')),
          ),
        ]);

      case 2:

        //Paralellogram สี่เหลี่ยมด้านขนาน

        return Column(children: [
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
                image:
                    AssetImage('assets/images/illustrator/paralellogram.png')),
          )
        ]);

      case 3:

        //Rhombus สี่เหลี่ยมขนมเปียกปูน

        return Column(children: [
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
                        child: Image.asset(
                            'assets/images/equations/square_peri.png'),
                      ),
                    ],
                  ))
            ]),
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
                image: AssetImage('assets/images/illustrator/rhombus.png')),
          ),
        ]);

      case 4:

        //Trapezoid สี่เหลี่ยมคางหมู

        return Column(children: [
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
                      image: AssetImage(
                          'assets/images/equations/trapezoid_area.png')))
            ]),
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage('assets/images/illustrator/trapezoid.png'),
            ),
          )
        ]);

      case 5:

        //Kite สี่เหลี่ยมรูปว่าว

        return Column(children: [
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
                        image: AssetImage(
                            'assets/images/equations/kite_area.png')),
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
                  child:
                      Image.asset('assets/images/equations/rectangle_peri.png'))
            ])
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage('assets/images/illustrator/kite.png'),
            ),
          )
        ]);

      case 6:

        //Trapezium สี่เหลี่ยมด้านไม่เท่า

        return Column(children: [
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
                      image: AssetImage(
                          'assets/images/equations/trapezium_area.png')))
            ]),
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage('assets/images/illustrator/trapezium.png'),
            ),
          ),
        ]);

      case 7:

        //Triangle สามเหลี่ยม

        return Column(children: [
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
                        image: AssetImage(
                            'assets/images/equations/triangle_s.png')),
                  ))
            ]),
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
                image: AssetImage('assets/images/illustrator/triangle.png')),
          )
        ]);

      case 8:

        //Right-Triangle สี่เหลี่ยมมุมฉาก

        return Column(
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
            )
          ],
        );

      case 9:

        //Circle วงกลม

        return Column(children: [
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
                      child: Image.asset(
                          'assets/images/equations/circle_peri.png'),
                    ),
                  ],
                ),
              )
            ]),
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image(
                image: AssetImage('assets/images/illustrator/circle.png')),
          )
        ]);

      case 10:

        //Ellipse วงรี

        return Column(
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
              child: Image(
                  image: AssetImage('assets/images/illustrator/ellipse.png')),
            )
          ],
        );

      default:

        //Square สี่เหลี่ยมจตุรัส

        return Column(
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
              child: Image(
                  image: AssetImage('assets/images/illustrator/square.png')),
            ),
          ],
        );
    }
  }
}
