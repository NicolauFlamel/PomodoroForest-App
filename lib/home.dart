import 'package:flutter/material.dart';
import 'garden_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class PomodoroPage extends StatefulWidget {
  @override
  _PomodoroPageState createState() => _PomodoroPageState();
}

class _PomodoroPageState extends State<PomodoroPage> {
  int _minutes = 25;
  int _seconds = 0;
  int _coins = 0;
  bool _isRunning = false;
  late Timer _timer;

  String _treeName = 'Your Tree Name';
  String _treeImageAsset = 'assets/your_tree_image.png';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final CollectionReference gardenCollection =
      FirebaseFirestore.instance.collection('Garden-Trees');

  final GardenService _gardenService = GardenService();

  void _stopTimer() {
    if (_isRunning) {
      _timer.cancel();
      _isRunning = false;
      _addTreeToGarden();
    }
  }

  void _addTreeToGarden() {
    String name = _treeName; 
    String imageAsset = _treeImageAsset; 
    _gardenService.addTree(name, imageAsset);
  }

  void _startTimer() {
    if (!_isRunning) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (_seconds > 0) {
            _seconds--;
          } else if (_minutes > 0) {
            _minutes--;
            _seconds = 59;
          } else {
            _isRunning = false;
            _timer.cancel();
          }
        });
      });
      _isRunning = true;
    }
  }

  void _resetTimer() {
    setState(() {
      _minutes = 20;
      _seconds = 0;
      if (_isRunning) {
        _timer.cancel();
        _isRunning = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_minutes > 20) {
      _treeName = 'Oak Sapling';
      _treeImageAsset = 'assets/oak_sapling.png';
    } else if(_minutes > 15 && _minutes < 20) {
      _treeName = 'Log';
      _treeImageAsset = 'assets/wood.png';
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(81, 163, 135, 1),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            );
          },
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 8, bottom: 8, right: 8),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.6),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/coin.webp',
                  width: 30,
                  height: 30,
                ),
                SizedBox(width: 10),
                Text('$_coins', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: const Color.fromRGBO(81, 163, 135, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 199, 181, 24),
                ),
                child: Center(
                  child: Image.asset(
                    _treeImageAsset, 
                    width: 150,
                    height: 150,
                  ),
                ),
              ),
              Container(
                width: 180,
                height: 180,
                child: CircularProgressIndicator(
                  value: (_minutes * 60 + _seconds) / (25 * 60),
                  backgroundColor:
                      const Color.fromARGB(255, 219, 200, 27).withOpacity(0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromARGB(255, 139, 137, 4),
                  ),
                  strokeWidth: 10,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            '$_minutes:${_seconds.toString().padLeft(2, '0')}',
            style: TextStyle(fontSize: 48, color: Colors.white),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _startTimer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 93, 202, 166),
                ),
                child: Text('Iniciar'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _stopTimer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 93, 202, 166),
                ),
                child: Text('Parar'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _resetTimer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 93, 202, 166),
                ),
                child: Text('Reiniciar'),
              ),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        width: 200,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(81, 163, 135, 1),
              ),
              child: Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configurações'),
              onTap: () {
                Navigator.pushNamed(context, '/home/settings');
              },
            ),
            ListTile(
              leading: Icon(Icons.sunny),
              title: Text('Floresta'),
              onTap: () {
                Navigator.pushNamed(context, '/home/garden');
              },
            ),
            ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text('Loja'),
              onTap: () {
                Navigator.pushNamed(context, '/home/shop');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pushNamed(context, '/');
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_isRunning) {
      _timer.cancel();
    }
    super.dispose();
  }
}