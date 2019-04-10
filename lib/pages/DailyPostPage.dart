import 'package:flutter/material.dart';
import 'DailyPostDetailPage.dart';

class DailyPostPage extends StatefulWidget {
  @override
  _DailyPostPageState createState() => _DailyPostPageState();
}

class _DailyPostPageState extends State<DailyPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f3f5),
      body: GestureDetector(
        onVerticalDragEnd:(details){
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => DailyPostDetailPage()
            )
          );
        },
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //开源日报封面图
              Image.network(
                'https://openingsource.org/wp-content/uploads/2019/04/opensource_daily_vol_391.jpg'
              ),
              Text(
                '开源日报',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ),
    );
  }
}
