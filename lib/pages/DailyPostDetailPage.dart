import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import '../utils/NetWork.dart';
import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';

class DailyPostDetailPage extends StatefulWidget {
  DailyPostDetailPage(this.postID);
  final postID;
  @override
  _DailyPostDetailPageState createState() => _DailyPostDetailPageState();
}

class _DailyPostDetailPageState extends State<DailyPostDetailPage> {
  
  Map <String, dynamic> post = {};

  @override
  void initState() {
    super.initState();
    Network.get("posts/${widget.postID}",).then((data) {
      if (data['status'] == 'ok' && data['code'] == 200) {
        Map <String, dynamic> item = data['data'];
        String temp; //临时变量
        //文章ID
        post['id'] = item['id']; 
        //发布时间
        temp = item['date'].toString();
        post['year'] = temp.substring(0,4);
        post['month'] = temp.substring(5,7);
        post['day'] = temp.substring(8,10);
        //文章标题
        temp = item['title']['rendered'];
        post['title'] = temp;
        post['vol'] = temp.substring(5,8);
        //封面
        temp = item['content_first_image'];
        post['DailyVolImage'] = temp.replaceAll("_vol_", "_cover_vol_");
        //文章内容
        post['contentUrl'] = item['content']['rendered'];
        post['contentMD'] = html2md.convert(post['contentUrl']);
        print(post);
        if(mounted) setState(() {}); // 防止setState() called after dispose()出现
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return post.isEmpty
    ? Container(
        color: Color(0xfff2f3f5),
        padding: EdgeInsets.all(30),
        child: Center(
          child: CircularProgressIndicator()
        )
      )
    : Scaffold(
      backgroundColor: Colors.white,
      body: _buildBody(),
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
              image: NetworkImage(post['DailyVolImage']),
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
                    post['title'],
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
          child: MarkdownBody(data: post['contentMD']),
        ),
      ]
    );
  }
}
