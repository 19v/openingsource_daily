import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

class DailyPostDetailPage extends StatefulWidget {
  @override
  _DailyPostDetailPageState createState() => _DailyPostDetailPageState();
}

class _DailyPostDetailPageState extends State<DailyPostDetailPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: Colors.white,
        notificationPredicate: defaultScrollNotificationPredicate,
        semanticsLabel: "喵",
        onRefresh:() { Navigator.pop(context); },
        child: _buildBody(),
      ),
    );
  }

  _buildBody(){
    return ListView(
      padding: EdgeInsets.all(0),
      children:<Widget> [
        Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Image(
              image: NetworkImage('https://openingsource.org/wp-content/uploads/2019/04/opensource_daily_cover_vol_391.jpg'),
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.width/4*3,
            ),
            Positioned(
              child: Container(
                height: MediaQuery.of(context).size.width/4*3,
                width: MediaQuery.of(context).size.width,
                color: Color(0x99000000),
                child: Container(
                  padding: EdgeInsets.fromLTRB(20,20,20,0),
                  alignment: Alignment.center,
                  child: Text(
                    "开源日报第391期\n《弹钢琴 AutoPiano》",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                      letterSpacing: 1.0
                    )
                  )
                ),
              )
            ),
            Positioned(
              top: MediaQueryData.fromWindow(window).padding.top,
              left: 0,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                onPressed: () => { Navigator.pop(context) },
              )
            )
          ],
        ),
        Container(
          padding: EdgeInsets.all(20),
          color: Colors.white,
          child: Text(
            "这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文这个是正文",
            textAlign: TextAlign.left,
            textDirection: TextDirection.ltr,
            softWrap: true,
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.normal,
              height: 1.5,
              letterSpacing: 0.5
            )
          ),
        ),
      ]
    );
  }
}
