import 'package:flutter/material.dart';
import './pages/DailyPostPage.dart';
import './pages/CalendarPage.dart';
import './pages/SettingPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // Root of application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '开源日报',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

//首页，定义导航栏等基本框架。

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 底部导航栏具体实现
  int _currentIndex = 1;
  final List<Widget> _children = [ 
    CalendarPage(),
    DailyPostPage(),
    SettingPage()
  ];
  final List<BottomNavigationBarItem> _list = <BottomNavigationBarItem>[
    _navBarSet(Icons.calendar_today, "日历"),
    _navBarSet(Icons.adb, "今日推送"),
    _navBarSet(Icons.settings, "设置"),
  ];
  // 页面标题
  String _createTitle() {
    String _title;
    switch(_currentIndex) {
      case 0:
        _title = "往期日报";
        break;
      case 1:
        _title = "今日日报";
        break;
      case 2:
        _title = "各项设置";
        break;
      default:
        _title = "404";
        break;
    }
    return _title;
  }
  // 页面生成
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_createTitle()),
      ),
      body: _children[_currentIndex],
      //底部导航
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        fixedColor: Color(0xFFF2F3F5),
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: _list
      ),
    );
  }
}

//底部栏每个选项卡的实现
BottomNavigationBarItem _navBarSet(icons, text){
  return BottomNavigationBarItem(
    icon: Icon(
      icons,
      color: Colors.black87,
    ),
    title: Text(
      text, 
      style: TextStyle(
        fontFamily: 'FZXYJT',
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      )
    )
  );
}
