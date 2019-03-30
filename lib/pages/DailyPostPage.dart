import 'package:flutter/material.dart';

class DailyPostPage extends StatefulWidget {
  @override
  _DailyPostPageState createState() => _DailyPostPageState();
}

class _DailyPostPageState extends State<DailyPostPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //开源日报封面图
            Image.network(
              'https://openingsource.org/wp-content/uploads/2019/03/opensource_daily_vol_374.jpg'
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), 
    );
  }
}
