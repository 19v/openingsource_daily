import 'package:flutter/material.dart';
import '../pages/DailyPostDetailPage.dart';

class DailyPostWidget extends StatelessWidget {
  DailyPostWidget(this.todayPosts);
  final todayPosts;

  @override
  Widget build(BuildContext context) {
    return todayPosts.isEmpty
      ? Container(
          color: Color(0xfff2f3f5),
          padding: EdgeInsets.all(30),
          child: Center(
            child: CircularProgressIndicator()
          )
        )
      : GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => DailyPostDetailPage(todayPosts['id'])
          )
        );
      },
      onVerticalDragEnd:(details){
        Navigator.push(
          context,
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => DailyPostDetailPage(todayPosts['id'])
          )
        );
      },
      child: Container(
        alignment: Alignment.center,
        child: Container(
          height: 500,
          padding: EdgeInsets.all(32),
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      todayPosts['year']+"年"+todayPosts['month']+"月"+todayPosts['day']+"日",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xff666666),
                        fontWeight: FontWeight.w500,
                      )
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:<Widget> [
                        Text(
                          "VOL.  ",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff282828),
                            fontWeight: FontWeight.w600
                          )
                        ),
                        Text(
                          todayPosts['vol'],
                          style: TextStyle(
                            fontSize: 40,
                            color: Color(0xff282828),
                            fontWeight: FontWeight.w700,
                          )
                        )
                      ]
                    ),
                  ],
                )
              ),
              //开源日报封面图
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x10000000),
                      offset: Offset(0.0, 1.0),
                      blurRadius: 10.0,
                      spreadRadius: 1.0
                    ),
                  ]
                ),
                padding: EdgeInsets.only(bottom: 20),
                child: Image.network(
                  todayPosts['DailyVolImage'],
                  fit: BoxFit.cover,
                ),
              ),
              //标题
              Text(
                "今日项目",
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color(0xffaaaaaa),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                )
              ),
              Container(
                padding: EdgeInsets.only(top:8),
                alignment: Alignment.centerLeft,
                child: Text(
                  todayPosts['title'],
                  textAlign: TextAlign.start,
                  softWrap: false,
                  overflow: TextOverflow.fade,                 
                  style: TextStyle(
                    color: Color(0xff282828),
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                  )
                )
              ),
            ],
          ),
        )
      ),
    );
  }
}