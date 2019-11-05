import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../widget/DailyPostWidget.dart';
import '../utils/NetWork.dart';

class DailyPostPage extends StatefulWidget {
  @override
  _DailyPostPageState createState() => _DailyPostPageState();
}

class _DailyPostPageState extends State<DailyPostPage> with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true;
  
  int _page = 1;  //日报序号

  Map <String, dynamic> todayPosts = {};

  @override
  void initState() {
    super.initState();
    _getDailyPostData(_page);
  }

  /* 使用API获取今日日报的数据。
   * 参数说明：
   * categories：167为日报的分类，不要动。
   * per_page：获取的一共篇数。
   * page：获取的日报篇序号……比如今天的是1，昨天的就是2。
   */
  void _getDailyPostData(int page) {
    Network.get("posts/",
      {
        "categories": 167,
        "per_page": 1,
        "page": page,
      },
    ).then((data) {
      if (data['status'] == 'ok' && data['code'] == 200) {
        todayPosts.clear();
        Map <String, dynamic> item = data['data'][0];
        //文章ID
        todayPosts['id'] = item['id']; 
        //发布时间
        DateTime _date = DateTime.parse(item['date']);
        todayPosts['year'] = _date.year.toString();
        todayPosts['month'] = _date.month.toString();
        todayPosts['day'] = _date.day.toString();
        //文章标题
        String _title = item['title']['rendered'];
        todayPosts['title'] = _title.substring(_title.indexOf('《'));
        todayPosts['vol'] = _title.substring(_title.indexOf('第')+1, _title.indexOf('期'));
        //封面
        todayPosts['DailyVolImage'] = item['content_first_image'];
        print(todayPosts);
        if(mounted) setState(() {}); // 防止setState() called after dispose()出现
      }
    });
  }

  /* 日期调整 */
  String _getDate() {
    DateTime nowTime = DateTime.now();
    DateTime showTime = nowTime.subtract(Duration(days: (_page-1)));
    String showTimeStr = showTime.year.toString() + "年" + showTime.month.toString() + "月" + showTime.day.toString() + "日";
    return showTimeStr;
  }
  
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Color(0xfff2f3f5),
      body: DailyPostWidget(todayPosts),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Color(0xfff2f3f5),
        child: Container(
          height: 60,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                padding: EdgeInsets.all(0),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                disabledColor: Colors.transparent,
                icon: Icon(Icons.keyboard_arrow_left, color: Color(0xff666666)),
                onPressed: () {
                  setState(() {
                    _page += 1;
                    todayPosts.clear();
                    _getDailyPostData(_page);
                  });
                }
              ),
              Container(
                padding: EdgeInsets.fromLTRB(30,10,30,10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xffe0e0e0),
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: Text(
                  _getDate(),
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xff666666),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5
                  ),
                ),
              ),
              IconButton(
                padding: EdgeInsets.all(0),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                disabledColor: Colors.transparent,
                icon: Icon(Icons.keyboard_arrow_right, color: Color(0xff666666)),
                onPressed: () {
                  if(_page > 1) {
                    setState(() {
                      todayPosts.clear();
                      _page -= 1;
                    });
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
