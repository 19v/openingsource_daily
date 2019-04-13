import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'DailyPostDetailPage.dart';
import 'dart:async';
import 'dart:convert';
import '../utils/NetWork.dart';

class DailyPostPage extends StatefulWidget {
  @override
  _DailyPostPageState createState() => _DailyPostPageState();
}

class _DailyPostPageState extends State<DailyPostPage> {
  
  Map <String, dynamic> todayPosts = {};

  @override
  void initState() {
    super.initState();
    Network.get("posts/",
      {
        "categories": 167,
        "per_page": 1,
        "page": 1,
      },
    ).then((data) {
      if (data['status'] == 'ok' && data['code'] == 200) {
        Map <String, dynamic> item = data['data'][0];
        String temp; //临时变量
        //文章ID
        todayPosts['id'] = item['id']; 
        //发布时间
        temp = item['date'].toString();
        todayPosts['year'] = temp.substring(0,4);
        todayPosts['month'] = temp.substring(5,7);
        todayPosts['day'] = temp.substring(8,10);
        //文章标题
        temp = item['title']['rendered'];
        todayPosts['title'] = temp.substring(11,temp.length-1);
        todayPosts['vol'] = temp.substring(5,8);
        //封面
        todayPosts['DailyVolImage'] = item['content_first_image'];
        print(todayPosts);
        if(mounted) setState(() {}); // 防止setState() called after dispose()出现
      }
    });
  }

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
    : Scaffold(
      backgroundColor: Color(0xfff2f3f5),
      body: GestureDetector(
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
          padding: EdgeInsets.fromLTRB(32,32,32,60),
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
                          "VOL / ",
                          style: TextStyle(
                            fontSize: 14,
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
                padding: EdgeInsets.only(top:8, bottom: 20),
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
              //上滑打开提示
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "↑ 上滑以阅读 ↑",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffacacac),
                    )
                  ),
                )
              )
            ],
          ),
        )
      ),
    );
  }
}
