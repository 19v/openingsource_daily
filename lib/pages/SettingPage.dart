import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f3f5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              IconData(0xe609, fontFamily: 'iconfont', matchTextDirection: true),
              size: 64,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                '此页为设置页，还没做好。',
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
