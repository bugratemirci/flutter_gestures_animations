import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int tapsCount = 0;
  int doubleTapsCount = 0;
  int longPressCount = 0;
  double xPosition = 0.0;
  double yPosition = 0.0;
  double boxSize = 0.0;
  double fullBoxSize = 150.0;

  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 10000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceInOut);
    animation.addListener(() {
      setState(() {
        boxSize = fullBoxSize * animation.value;
      });
      centerBox(context);
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (xPosition == 0.0) {
    //   centerBox(context);
    // }

    return Scaffold(
      appBar: AppBar(title: Text("Gestures demo")),
      body: GestureDetector(
          onTap: () {
            setState(() {
              tapsCount += 1;
            });
          },
          onDoubleTap: () {
            setState(() {
              doubleTapsCount += 1;
            });
          },
          onLongPress: () {
            setState(() {
              longPressCount += 1;
            });
          },
          onVerticalDragUpdate: (DragUpdateDetails value) {
            setState(() {
              double delta = value.delta.dy;
              yPosition += delta;
            });
          },
          onHorizontalDragUpdate: (DragUpdateDetails value) {
            setState(() {
              double deltaX = value.delta.dx;
              xPosition += deltaX;
            });
          },
          child: Stack(
            children: <Widget>[
              Positioned(
                left: xPosition,
                top: yPosition,
                child: Container(
                  width: boxSize,
                  height: boxSize,
                  decoration: BoxDecoration(color: Colors.red),
                ),
              )
            ],
          )),
      bottomNavigationBar: Material(
          color: Colors.red[300],
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
                "Tap count: $tapsCount Double tap count: $doubleTapsCount Long press count: $longPressCount"),
          )),
    );
  }

  void centerBox(BuildContext context) {
    xPosition = MediaQuery.of(context).size.width / 2.0 - boxSize / 2.0;
    yPosition = MediaQuery.of(context).size.height / 2.0 - boxSize / 2.0 - 30.0;
    setState(() {
      this.xPosition = xPosition;
      this.yPosition = yPosition;
    });
  }
}
