import 'dart:io';
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
  //double pos_l0 = 100;
  double pos_t0 = 200;
  //double pos_l1 = -60;
  double pos_t1 = -600;
  // double pos_l2 = -60;
  // double pos_t2 = 2000;

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
  // GlobalKey key1 = GlobalKey();
  // GlobalKey key2 = GlobalKey();
  // @override
  // void initState(){
  //   super.initState();
  //   WidgetsBinding.instance
  //       .addPostFrameCallback((_) => _moveCard());
  // }
  void _moveCard() {
    setState(() {
      // pos_l = 100;
      // pos_r = 0;
      // pos_t = 0;
      // pos_b = 100;
      //pos_l0 = 100;
      pos_t0 = 600;
      //pos_l1 = 20;
      pos_t1 = 200;
      // pos_l2 = 100;
      // pos_t2 = 200;
      //RenderBox ap1 = key1.currentContext.findRenderObject();

    });
  }
  // void _moveCard2() {
  //   setState(() {
  //     pos_l2 = 110;
  //     pos_t2 = 200;
  //
  //     //RenderBox ap1 = key1.currentContext.findRenderObject();
  //
  //   });
  //   // setState(() {
  //   //   if (pos == "Up") {
  //   //     pos_l = 0;
  //   //     pos_r = 0;
  //   //     pos_t = 0;
  //   //     pos_b = 100;
  //   //   } else if (pos == "Right") {
  //   //     pos_l = 100;
  //   //     pos_r = 0;
  //   //     pos_t = 0;
  //   //     pos_b = 0;
  //   //   } else if (pos == "Down") {
  //   //     pos_l = 0;
  //   //     pos_r = 0;
  //   //     pos_t = 100;
  //   //     pos_b = 0;
  //   //   } else if (pos == "Left") {
  //   //     pos_l = 0;
  //   //     pos_r = 100;
  //   //     pos_t = 0;
  //   //     pos_b = 0;
  //   //   }
  //   // });
  // }
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
                //key: key1,
                //eft: pos_l1,
                //right: pos_r,
                top: pos_t1,
                //bottom: pos_b,
                width: 400,
                height: 600,
                duration: Duration(milliseconds: 1000),
                child: GridView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: fileNames.length,
                  gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 10.0,
                      childAspectRatio: 0.75,
                    ),
                  itemBuilder: (context, i){
                    return AnimatedBlindCard(fileNames[i]);
                  },
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

              // AnimatedPositioned(
              //   //key: key2,
              //   left: pos_l2,
              //   //right: pos_r,
              //   top: pos_t2,
              //   //bottom: pos_b,
              //   duration: Duration(milliseconds: 1000),
              //   child: AnimatedBlindCard('assets/ysl.jpg'),
              // ),

              AnimatedPositioned(
                //key: key2,
                //left: pos_l0,
                //right: pos_r,
                top: pos_t0,
                //bottom: pos_b,
                duration: Duration(milliseconds: 1000),
                child: RaisedButton(
                  child: Text('Start'),
                  onPressed: () => _moveCard(),
                ),
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