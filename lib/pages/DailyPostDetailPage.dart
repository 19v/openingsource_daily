import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
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
  bool showToTopBtn = false; //是否显示“返回到顶部”按钮
  ScrollController _controller = ScrollController();

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
    //监听滚动事件，打印滚动位置
    _controller.addListener(() {
      //print(_controller.offset); //测试，打印滚动位置
      if (_controller.offset <= 150 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      } else if (_controller.offset > 150 && showToTopBtn == false) {
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 更改状态栏颜色
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
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
      // 正文
      body: NestedScrollView(
        controller: _controller,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget> [
            SliverAppBar(
              brightness: Brightness.dark,
              primary: true,
              expandedHeight: 200.0,
              pinned: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Color(0xffffffff)),
                onPressed: (){Navigator.pop(context);},
              ),
              centerTitle: true,
              title: Text(
                post['title'].toString().substring(0,post['title'].toString().indexOf('：')),
                textAlign: TextAlign.center,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                )
              ),
              actions: <Widget>[
                IconButton(
                  padding: EdgeInsets.all(0),
                  color: Colors.white,
                  icon: Icon(Icons.share),
                  onPressed: () {}
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Image(
                      image: NetworkImage(post['DailyVolImage']),
                      fit: BoxFit.cover,
                      height: 250.0,
                    ),
                    Positioned(
                      child: Container(
                        height: 250.0,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0x99000000),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 170.0,
                        width: MediaQuery.of(context).size.width * 0.8,
                        alignment: Alignment.center,
                        child: Text(
                          post['title'].toString().substring(post['title'].toString().indexOf('《')+1, post['title'].toString().indexOf('》')),
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                            letterSpacing: 1.2
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: ListView(
          padding: EdgeInsets.all(20),
          children: <Widget>[
            Container(
              color: Colors.white,
              child: MarkdownBody(data: post['contentMD']),
            ),
          ],
        )
      ),
      // 底栏
      bottomNavigationBar: BottomAppBar(
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 32,
                  margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  decoration: BoxDecoration(
                    color: Color(0xffe0e0e0),
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "在此书写评论",
                          style: TextStyle(
                            color: Color(0xffa0a0a0),
                            fontWeight: FontWeight.bold,
                          )
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.all(0),
                        color: Color(0xffaaaaaa),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        disabledColor: Colors.transparent,
                        icon: Icon(Icons.send, size: 16,),
                        onPressed: () {}
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget> [
                  IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(Icons.message, color: Color(0xff666666)),
                    onPressed: () {}
                  ),
                  IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(Icons.favorite_border, color: Color(0xff666666)),
                    onPressed: () {}
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // 返回顶部的浮动按钮
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: !showToTopBtn
      ? null
      : FloatingActionButton(
        mini: true,
        child: Icon(Icons.arrow_upward, color: Colors.white,),
        onPressed: () {
          //返回到顶部时执行动画
          _controller.animateTo(.0,
            duration: Duration(milliseconds: 200),
            curve: Curves.ease
          );
        }
      ),
    );
  }
}
