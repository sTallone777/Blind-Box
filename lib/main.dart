import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

const double gridWidth = 380.0;
const double gridHeight = gridWidth / 0.65;

class _MyHomePageState extends State<MyHomePage> {
  double buttonTop;
  double gridTop = -gridHeight;

  List<String> fileNames = [
    'assets/t1.JPG',
    'assets/t2.JPG',
    'assets/t3.JPG',
    'assets/t4.JPG',
    'assets/t5.JPG',
    'assets/t6.JPG',
    'assets/t7.JPG',
    'assets/t8.JPG',
    'assets/t9.JPG',
    'assets/t10.JPG',
    'assets/t11.JPG',
    'assets/t12.JPG',
    'assets/t13.JPG',
    'assets/t14.JPG',
    'assets/t15.JPG',
    'assets/t16.JPG',
  ];

  void _moveCard() {
    Size s = MediaQuery.of(context).size;
    setState(() {
      gridTop = (s.height - gridHeight) / 2;
      buttonTop = gridTop + gridHeight + 20.0;
    });
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
            alignment: Alignment.topCenter,
            children: <Widget>[
              AnimatedPositioned(
                top: gridTop,
                width: gridWidth,
                height: gridHeight,
                duration: Duration(milliseconds: 1000),
                child: GridView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: fileNames.length,
                  gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 5.0,
                      childAspectRatio: 0.75,
                    ),
                  itemBuilder: (context, i){
                    return AnimatedBlindCard(fileNames[i]);
                  },
                ),
              ),

              AnimatedPositioned(
                top: buttonTop,
                duration: Duration(milliseconds: 1000),
                child: RaisedButton(
                  child: Text('Start'),
                  onPressed: () => _moveCard(),
                ),
              ),
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
    _backAnimation = Tween<double>(begin: 0.0, end: 0.5 * pi).animate(CurvedAnimation(parent: _blindCardController, curve: Interval(0, 0.5)));
    _frontAnimation = Tween<double>(begin: 1.5 * pi, end: 2 * pi).animate(CurvedAnimation(parent: _blindCardController, curve: Interval(0.5, 1)));
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
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          image: DecorationImage(
            image: AssetImage(imgPath),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            new BoxShadow(
                color: Colors.black26,
                offset: new Offset(2.0, 2.0),
                blurRadius: 4.0,
                spreadRadius: 0.0)
          ]),
      // width: 60.0,
      // height: 80.0,
    );
  }
}