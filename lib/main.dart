import 'package:flutter/material.dart';
import 'package:flutter_foreground_service/flutter_foreground_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shake/shake.dart';
import 'package:torch/torch.dart';

void main() {
  
  runApp(MyApp());
  startForegroundService();
}

void startForegroundService() async {
  ForegroundService().start();
  debugPrint("Started service");
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isVisible = true;
  var textt = "Turn On";

  void toff() {
    setState(() {
      textt = "Turn Off";
    });
  }

  void ton() {
    setState(() {
      textt = "Turn On";
    });
  }

  torchon() {
    if (_isVisible) {
      _isVisible = false;
      toff();

      Torch.turnOn();
    } else {
      _isVisible = true;
      ton();
      Torch.turnOff();
    }
  }
  shakedet(){
    ShakeDetector detector = ShakeDetector.autoStart(
    onPhoneShake: () {
      print("HELLO WORLD");
      torchon();
        // Do stuff on phone shake
    }
);

  }
  @override
  void initState(){
    shakedet();
    super.initState();

  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Torch App")),
        backgroundColor: Colors.grey[600],
      ),
      backgroundColor: Colors.grey[900],
      body: Container(
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              GestureDetector(
                  onTap: () {torchon();},
                  child: Column(
                    children: [
                      Icon(
                        FontAwesomeIcons.lightbulb,
                        color: _isVisible
                            ? Colors.grey[600]
                            : Colors.yellow.shade600,
                        size: 200,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 50,
                        width: 80,
                        color: _isVisible
                            ? Colors.grey[600]
                            : Colors.yellow.shade600,
                        padding: EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            textt,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ))
            ])),
      ),
    );
  }
 @override
  void dispose() {
    ForegroundService().stop();
    super.dispose();
  }
}