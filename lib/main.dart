import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Blind-Box',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title: 'Blind-Box'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  double pos_l = -100;
  double pos_r = -100;
  double pos_t = 0;
  double pos_b = 0;
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _movewidget());
  }
  void _movewidget() {
    setState(() {
          // pos_l = 100;
          // pos_r = 0;
          // pos_t = 0;
          // pos_b = 100;
      pos_l = 200;
      pos_t = 400;
    });
    // setState(() {
    //   if (pos == "Up") {
    //     pos_l = 0;
    //     pos_r = 0;
    //     pos_t = 0;
    //     pos_b = 100;
    //   } else if (pos == "Right") {
    //     pos_l = 100;
    //     pos_r = 0;
    //     pos_t = 0;
    //     pos_b = 0;
    //   } else if (pos == "Down") {
    //     pos_l = 0;
    //     pos_r = 0;
    //     pos_t = 100;
    //     pos_b = 0;
    //   } else if (pos == "Left") {
    //     pos_l = 0;
    //     pos_r = 100;
    //     pos_t = 0;
    //     pos_b = 0;
    //   }
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          child: Stack(
            children: <Widget>[
              AnimatedPositioned(
                left: pos_l,
                //right: pos_r,
                top: pos_t,
                //bottom: pos_b,
                duration: Duration(milliseconds: 5000),
                child: Card(
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    color: Colors.purple,
                  ),
                ),

                // child: Center(
                //   child: Container(
                //     alignment: Alignment.center,
                //     color: Colors.purple,
                //     width: 100.0,
                //     height: 100.0,
                //   ),
                // ),
              ),
              // Positioned(
              //   bottom: 100,
              //   left: 160,
              //   child: RaisedButton(
              //     onPressed: () {
              //       _movewidget("Up");
              //     },
              //     child: Icon(Icons.keyboard_arrow_up),
              //   ),
              // ),
              // Positioned(
              //   bottom: 60,
              //   left: 260,
              //   child: RaisedButton(
              //     onPressed: () {
              //       _movewidget("Right");
              //     },
              //     child: Icon(Icons.keyboard_arrow_right),
              //   ),
              // ),
              // Positioned(
              //   bottom: 10,
              //   left: 160,
              //   child: RaisedButton(
              //     onPressed: () {
              //       _movewidget("Down");
              //     },
              //     child: Icon(Icons.keyboard_arrow_down),
              //   ),
              // ),
              // Positioned(
              //   bottom: 60,
              //   left: 60,
              //   child: RaisedButton(
              //     onPressed: () {
              //       _movewidget("Left");
              //     },
              //     child: Icon(Icons.keyboard_arrow_left),
              //   ),
              // )
            ],
          ),
        )
      ),
    );
  }
}

class AnimatedBlindCard extends StatefulWidget{
  final String frontImg;
  final String backImg = 'assets/back.jpg';
  AnimatedBlindCard(this.frontImg);
  @override
  _AnimatedBlindCardState createState() => _AnimatedBlindCardState();
}

class _AnimatedBlindCardState extends State<AnimatedBlindCard> with TickerProviderStateMixin{
  AnimationController _blindCardController;
  Animation<double> _frontAnimation;
  Animation<double> _backAnimation;
  @override
  void initState(){
    super.initState();
    _blindCardController = AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _frontAnimation = Tween<double>(begin: 0.0, end: 0.5 * pi).animate(CurvedAnimation(parent: _blindCardController, curve: Interval(0, 0.5)));
    _backAnimation = Tween<double>(begin: 1.5 * pi, end: 2 * pi).animate(CurvedAnimation(parent: _blindCardController, curve: Interval(0.5, 1)));
  }

  @override
  void dispose(){
    _blindCardController.dispose();
    super.dispose();
  }

  void blindCard(){
    if(_blindCardController.isDismissed){
      _blindCardController.forward();
    }else{
      _blindCardController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Stack(
          children: <Widget>[
            AnimatedBuilder(
              child: GestureDetector(
                //child: CustomCard('Back', Colors.white),
                child: BlindCard(widget.backImg),
                onTap: blindCard,
              ),
              animation: _backAnimation,
              builder: (BuildContext context, Widget child) {
                return Transform(
                  alignment: FractionalOffset.center,
                  child: child,
                  transform: Matrix4.identity()
                    ..rotateY(_backAnimation.value),
                );
              }
            ),
            AnimatedBuilder(
              child: GestureDetector(
                //child: CustomCard('Front', Colors.orangeAccent),
                child: BlindCard(widget.frontImg),
                onTap: blindCard,
              ),
              animation: _frontAnimation,
              builder: (BuildContext context, Widget child) {
                return Transform(
                  alignment: FractionalOffset.center,
                  child: child,
                  transform: Matrix4.identity()
                    ..rotateY(_frontAnimation.value),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}

class BlindCard extends StatelessWidget{
  final String imgPath;
  BlindCard(this.imgPath);

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
          boxShadow: [
            new BoxShadow(
                color: Colors.black26,
                offset: new Offset(2.0, 2.0),
                blurRadius: 4.0,
                spreadRadius: 0.0)
          ]),
      width: 60.0,
      height: 80.0,
      child: Image.asset(
        imgPath,
        fit: BoxFit.cover,
      ),
    );
  }
}